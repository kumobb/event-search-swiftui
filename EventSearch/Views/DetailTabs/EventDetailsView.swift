//
//  EventDetailsView.swift
//  EventSearch
//
//  Created by Desmond Wu on 4/21/23.
//

import SwiftUI

struct EventDetailsView: View {
    let eventId: String
    
    @State private var isLoading = true
    @State private var eventDetails: EventDetails?
    @State private var artistDetails: [ArtistDetails] = []
    @State private var venueDetails: VenueDetails?
    
    var body: some View {
        ZStack {
            if(isLoading) {
                ProgressView("Please wait...")
            } else {
                TabView {
                    if let event = eventDetails {
                        EventTabView(eventDetails: event)
                            .tabItem {
                                Label("Events", systemImage: "text.bubble")
                            }
                    } else {
                        Text("Loading...")
                    }
                    
                    ArtistsTabView(artistDetailsArray: artistDetails)
                        .tabItem {
                            Label("Artist/Team", systemImage: "guitars")
                        }
                    
                    if let event = eventDetails, let venue = venueDetails {
                        VenueTabView(eventName:event.name, venueDetails: venue)
                            .tabItem {
                                Label("Venue", systemImage: "location.fill")
                            }
                    }
                }
                
            }
        }
        .onAppear {
            Task {
                eventDetails = await fetchEventDetails(eventId)
                
                if let event = eventDetails, let artists = event.artists {
                    artistDetails = await fetchArtistDetails(artists)
                }
                
                if let event = eventDetails {
                    venueDetails = await fetchVenueDetails(event.venue)
                }
                
                isLoading = false
            }
        }
        
    }
}

struct EventDetailsView_Previews: PreviewProvider {
    static let favorites = FavoritesData()
    
    static var previews: some View {
        EventDetailsView(eventId: "vvG10Z9ISN9d2c")
            .environmentObject(favorites)
    }
}
