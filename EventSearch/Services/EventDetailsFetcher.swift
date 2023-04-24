//
//  EventDetailsFetcher.swift
//  EventSearch
//
//  Created by Desmond Wu on 4/21/23.
//

import Foundation

func fetchEventDetails(_ eventId: String) async -> EventDetails? {
    do {
        let url = URL(string: "https://event-search-react.wl.r.appspot.com/api/event?id=\(eventId)")!
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoded = try JSONDecoder().decode(EventDetails.self, from: data)
        return decoded
    } catch {
        print("Error fetching event details: \(error)")
    }
    
    return nil
}
