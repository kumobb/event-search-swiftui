//
//  ArtistCard.swift
//  EventSearch
//
//  Created by Desmond Wu on 4/22/23.
//

import SwiftUI

struct ArtistCard: View {
    let artistDetails: ArtistDetails
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                if let image = artistDetails.image {
                    AsyncImage(url: URL(string: image)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 115, height: 115)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                else {
                    Image(systemName: "person.crop.circle.badge.questionmark")
                        .font(.system(size: 80))
                        .frame(width: 115, height: 115)
                }
                
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text(artistDetails.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .bold()
                        .lineLimit(1)
                        .padding(.bottom)
                    HStack {
                        Text(artistDetails.followers.formatted)
                            .font(.title3)
                            .fontWeight(.semibold)
                        Text("Followers")
                            .font(.subheadline)
                    }
                    

                    Button(action: {
                        if let url = URL(string: "https://open.spotify.com/artist/\(artistDetails.id)") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        HStack {
                            Image("spotify_logo")
                                .resizable()
                                .frame(width: 35, height: 35)
                            Text("Spotify")
                                .foregroundColor(Color.green)
                            
                        }
                    }
                }
                
                Spacer()
                VStack {
                    Text("Popularity")
                        .fontWeight(.semibold)
                        .padding(.bottom)
                    ZStack {
                        Text("\(artistDetails.popularity)")
                            .font(.title3)
                        Circle()
                            .stroke(
                                Color.orange.opacity(0.5),
                                lineWidth: 15
                            )
                        Circle()
                            .trim(from: 0, to: Double(artistDetails.popularity) / 100.0) // 1
                            .stroke(
                                Color.orange,
                                lineWidth: 15
                            )
                    }
                    .frame(width: 65, height: 65)
                }
            }
            
            VStack(alignment: .leading) {
                Text("Popular Albums")
                    .font(.title2)
                    .fontWeight(.bold)
                
                HStack(spacing: 35) {
                    ForEach(artistDetails.albums, id: \.self) { album in
                        AsyncImage(url: URL(string: album)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 90, height: 90)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.black.opacity(0.65))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .frame(width: 370)
    }
}

struct ArtistCard_Previews: PreviewProvider {
    static var artistDetails = ArtistDetails(
        id: "6eUKZXaKkcviH0Ku9w2n3V",
        name: "Ed Sheeran",
        followers: 111312734,
        popularity: 91,
        link: "spotify:artist:6eUKZXaKkcviH0Ku9w2n3V",
        image: "https://i.scdn.co/image/ab6761610000e5eb9e690225ad4445530612ccc9",
        albums: [
            "https://i.scdn.co/image/ab67616d0000b273a9473656bdf001fd00a4fa13",
            "https://i.scdn.co/image/ab67616d0000b273dd51c567ae17b0a609be81f9",
            "https://i.scdn.co/image/ab67616d0000b273aefa57a1ad78ad4a907a5ab6"
        ]
    )
    
    static var previews: some View {
        ArtistCard(artistDetails: artistDetails)
    }
}
