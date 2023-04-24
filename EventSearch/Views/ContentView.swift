//
//  ContentView.swift
//  EventSearch
//
//  Created by Desmond Wu on 4/3/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var favoritesData = FavoritesData()
    
    var body: some View {
        SearchPageView()
            .environmentObject(favoritesData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
