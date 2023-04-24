//
//  ArtistsTabView.swift
//  EventSearch
//
//  Created by Desmond Wu on 4/22/23.
//

import SwiftUI

struct ArtistsTabView: View {
    let artistDetailsArray:[ArtistDetails]
    
    var body: some View {
        if(artistDetailsArray.isEmpty) {
            Text("No music related artist details to show")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
        } else {
            ScrollView {
                ForEach(artistDetailsArray) { artist in
                    ArtistCard(artistDetails: artist)
                        .padding(.vertical)
                }
                .padding()
            }
        }
    }
}

struct ArtistsTabView_Previews: PreviewProvider {
    
    static var artists = [ArtistDetails(
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
        ]), ArtistDetails(
            id: "1z7b1Pr1rSlvWRzsW3HOrS",
            name: "Russ",
            followers: 4789087,
            popularity: 78,
            link: "spotify:artist:1z7b1Pr1rSlvWRzsW3HOrS",
            image: "https://i.scdn.co/image/ab6761610000e5eb64575cc66fdce98eba7cee22",
            albums: [
                "https://i.scdn.co/image/ab67616d0000b2733e36f41145dfc8a38a488020",
                "https://i.scdn.co/image/ab67616d0000b273039f0bcf97bf66ca8e1f736d",
                "https://i.scdn.co/image/ab67616d0000b273675fc8cf82a0c1024862a9dc"
            ]
        ), ArtistDetails(
            id: "2RVvqRBon9NgaGXKfywDSs",
            name: "Maisie Peters",
            followers: 478223,
            popularity: 67,
            link: "spotify:artist:2RVvqRBon9NgaGXKfywDSs",
            image: "https://i.scdn.co/image/ab6761610000e5ebb22bbb3a26e8b3d6ed50d7ab",
            albums: [
                "https://i.scdn.co/image/ab67616d0000b273084229044ca0f2f9f43584cc",
                "https://i.scdn.co/image/ab67616d0000b273d4d5ddbcc086f6017df445a6",
                "https://i.scdn.co/image/ab67616d0000b273c3a593c88f9e49d78b0a8e01"
            ])]
    
    static var previews: some View {
        ArtistsTabView(artistDetailsArray: artists)
    }
}
