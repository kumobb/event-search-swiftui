//
//  VenueDetailsFetcher.swift
//  EventSearch
//
//  Created by Desmond Wu on 4/22/23.
//

import Foundation

func fetchVenueDetails(_ keyword: String) async -> VenueDetails? {
    do {
        let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: "https://event-search-react.wl.r.appspot.com/api/venue?keyword=\(encodedKeyword)")!
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoded = try JSONDecoder().decode(VenueDetails.self, from: data)
        return decoded
    } catch {
        print("Error fetching event details: \(error)")
    }
    
    return nil
}
