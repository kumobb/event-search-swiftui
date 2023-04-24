//
//  ArtistDetailsFetcher.swift
//  EventSearch
//
//  Created by Desmond Wu on 4/22/23.
//

import Foundation

func fetchArtistDetails(_ artists: [EventDetails.Artist]) async -> [ArtistDetails] {
    var results: [ArtistDetails] = []
    
    for artist in artists {
        if(artist.segment != "Music") {
            continue
        }
        
        let encodedName = artist.name.replacingOccurrences(of: " ", with: "+").replacingOccurrences(of: "&", with: "%26")
        let url = URL(string: "https://event-search-react.wl.r.appspot.com/api/artist?keyword=\(encodedName)")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(ArtistDetails.self, from: data)
            results.append(decodedResponse)
        } catch {
            print("Error fetching artist details: \(error)")
        }
    }
    return results
}
