//
//  SearchResultsFetcher.swift
//  EventSearch
//
//  Created by Desmond Wu on 4/21/23.
//

import Foundation

func search(_ queries: SearchFormValues) async -> [EventItem] {
    do {
        let coordinates: [Double]
        
        if(queries.autoDetect) {
            coordinates = await getAutoCoordinates()
        }
        else {
            coordinates = await getCoordinates(address: queries.location)
        }
        
        if coordinates.isEmpty {
            return []
        }
        
        let url = URL(string: "https://event-search-react.wl.r.appspot.com/api/tickets")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems =
        [URLQueryItem(name: "keyword", value: queries.keyword),
         URLQueryItem(name: "distance", value: queries.distance),
         URLQueryItem(name: "category", value: queries.category),
         URLQueryItem(name: "lat", value: String(coordinates[0])),
         URLQueryItem(name: "lng", value: String(coordinates[1])),
        ]
        let request = URLRequest(url: components.url!)
        let (data, _) = try await URLSession.shared.data(for: request)
        let decodedEvents = try JSONDecoder().decode([EventItem].self, from: data)
        return decodedEvents
    } catch {
        print("Error fetching search results: \(error)")
    }
    
    return []
}

func getAutoCoordinates() async -> [Double] {
    let url = URL(string: "https://ipinfo.io/?token=c136e876ae7da8")!
    struct IPInfoResponse: Codable {
        let loc: String
    }
    
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let ipInfo = try decoder.decode(IPInfoResponse.self, from: data)
        
        let coordinates = ipInfo.loc.split(separator: ",").compactMap { Double($0) }
        return coordinates
    } catch {
        print("Error fetching coordinates: \(error)")
        return []
    }
}

func getCoordinates(address: String) async -> [Double] {
    let encodedAddress = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let apikey = "AIzaSyBzwsxp47RYuphIhc3fGP1TrX_-4U4INP8"
    let url = URL(string: "https://maps.googleapis.com/maps/api/geocode/json?key=\(apikey)&address=\(encodedAddress)")!
    
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        if let results = json?["results"] as? [[String: Any]],
           let location = results.first?["geometry"] as? [String: Any],
           let coordinates = location["location"] as? [String: Double],
           let latitude = coordinates["lat"],
           let longitude = coordinates["lng"] {
            return [latitude, longitude]
        } else {
            return []
        }
    } catch {
        print("Error fetching coordinates: \(error)")
        return []
    }
    
    
}
