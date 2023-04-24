//
//  FavoritePageView.swift
//  EventSearch
//
//  Created by Desmond Wu on 4/22/23.
//

import SwiftUI

struct FavoritePageView: View {
    @EnvironmentObject var favoritesData: FavoritesData
    
    var body: some View {
        ZStack {
            if(favoritesData.favoriteEvents.isEmpty) {
                Text("No favorites found")
                    .foregroundColor(.red)
            }
            else {
                List {
                    ForEach(favoritesData.favoriteEvents) { event in
                        HStack {
                            Text(event.date)
                            Spacer()
                            Text(event.event)
                                .lineLimit(2)
                            Spacer()
                            Text(event.category)
                            Spacer()
                            Text(event.venue)
                        }
                        .font(.caption)
                    }
                    .onDelete(perform: deleteFavorite)
                }
            }
        }
        .navigationTitle("Favorites")
    }
    
    func deleteFavorite(at offsets: IndexSet) {
        for index in offsets {
            let eventId = favoritesData.favoriteEvents[index].id
            favoritesData.remove(eventId: eventId)
        }
    }
}

struct FavoritePageView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritePageView()
            .environmentObject(FavoritesData())
    }
}
