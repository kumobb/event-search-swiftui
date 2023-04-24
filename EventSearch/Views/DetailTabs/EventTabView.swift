//
//  EventTabView.swift
//  EventSearch
//
//  Created by Desmond Wu on 4/21/23.
//

import SwiftUI
import SimpleToast

struct EventTabView: View {
    @State private var isShowingToast = false
    @State private var isFavorite = false
    @EnvironmentObject var favoritesData: FavoritesData
    
    let eventDetails: EventDetails
    
    let TWITTER_URL = "https://twitter.com/intent/tweet?"
    let FACEBOOK_URL = "https://www.facebook.com/share.php?u="
    
    let toastOptions = SimpleToastOptions(
        alignment: .bottom,
        hideAfter: 1
    )
    
    var statusBackgroundColor: Color {
        switch eventDetails.status {
        case "onsale":
            return Color.green
        case "rescheduled", "postponed":
            return Color.orange
        case "offsale":
            return Color.red
        case "canceled", "cancelled":
            return Color.black
        default:
            return Color.gray
        }
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text(eventDetails.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Date")
                            .fontWeight(.bold)
                        Text(eventDetails.date)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Artist | Team")
                            .fontWeight(.bold)
                        Text(eventDetails.artists?.map { $0.name }.joined(separator: " | ") ?? "")
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                }
                .padding(.bottom, 5)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Venue")
                            .fontWeight(.bold)
                        Text(eventDetails.venue)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Genre")
                            .fontWeight(.bold)
                        Text(eventDetails.genre.map { $0 }.joined(separator: " | "))
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                }
                .padding(.bottom, 5)
                
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Price Range")
                            .fontWeight(.bold)
                        Text(eventDetails.price)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Ticket Status")
                            .fontWeight(.bold)
                        Text(eventDetails.status.prefix(1).uppercased() + eventDetails.status.dropFirst())
                            .foregroundColor(.white)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 4)
                            .background(statusBackgroundColor)
                            .cornerRadius(4)
                    }
                }
                .padding(.bottom, 5)
                
                
                Button(action: {
                    isShowingToast = true
                    isFavorite = !isFavorite
                    if(isFavorite) {
                        favoritesData.add(event: FavoriteItem(
                            id: eventDetails.id,
                            date: eventDetails.date,
                            event: eventDetails.name,
                            category: eventDetails.genre.map { $0 }.joined(separator: " | "),
                            venue: eventDetails.venue))
                    }
                    else {
                        favoritesData.remove(eventId: eventDetails.id)
                    }
                    
                }) {
                    if(!isFavorite) {
                        Text("Save Event")
                            .padding(.vertical)
                            .padding(.horizontal, 15)
                            .background(.blue)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    } else {
                        Text("Remove Favorite")
                            .padding(.vertical)
                            .padding(.horizontal, 15)
                            .background(.red)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                }
                .buttonStyle(.borderless)
                .frame(maxWidth: .infinity)
                .onAppear {
                    isFavorite = favoritesData.isFavorite(eventId: eventDetails.id)
                }
                
                AsyncImage(url: URL(string: eventDetails.map ?? "https://placehold.jp/cccccc/ffffff/400x400.png?text=Seat%20Map%20Not%20Found")) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
                
                
                HStack {
                    Text("Buy Ticket At:")
                        .fontWeight(.bold)
                    Link("Ticketmaster", destination: URL(string: eventDetails.link)!)
                }
                .frame(maxWidth: .infinity)
                
                HStack {
                    Text("Share on:")
                        .fontWeight(.bold)
                    
                    Button(action: {
                        if let url = URL(string: "\(FACEBOOK_URL)\(eventDetails.link)") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Image("f_logo_RGB-Blue_144")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    
                    Button(action: {
                        if let encodedText = eventDetails.name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                           let url = URL(string: "\(TWITTER_URL)text=Check%20\(encodedText)%20on%20Ticketmaster.%0a&url=\(eventDetails.link)") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Image("Twitter social icons - circle - blue")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .blur(radius:isShowingToast ? 1 : 0)
        }
        .simpleToast(isPresented: $isShowingToast, options: toastOptions) {
            Text(isFavorite ? "Added to favorites." : "Removed from favorites")
                .padding(20)
                .background(Color.gray.opacity(0.8))
                .cornerRadius(10)
        }
    }
}

struct EventTabView_Previews: PreviewProvider {
    static var eventDetails = EventDetails(
        id: "vvG1IZ9KBiqNAT",
        name: "Ed Sheeran: +-=÷x Tour",
        date: "2023-09-23",
        artists: [
            EventDetails.Artist(name: "Ed Sheeran", segment: "Music"),
            EventDetails.Artist(name: "Russ", segment: "Music"),
            EventDetails.Artist(name: "Maisie Peters", segment: "Music"),
        ],
        venue: "SoFi Stadium",
        genre: ["Music", "Pop", "Pop"],
        price: "54 - 164 USD",
        status: "onsale",
        link: "https://www.ticketmaster.com/ed-sheeran-x-tour-inglewood-california-09-23-2023/event/0A005D3EAC76317F",
        map: "https://maps.ticketmaster.com/maps/geometry/3/event/0A005D3EAC76317F/staticImage?type=png&systemId=HOST"
    )
    
    static var previews: some View {
        EventTabView(eventDetails: eventDetails)
            .environmentObject(FavoritesData())
    }
}
