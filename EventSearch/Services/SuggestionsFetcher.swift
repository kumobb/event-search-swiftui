//
//  Autocomplete.swift
//  EventSearch
//
//  Created by Desmond Wu on 4/5/23.
//

import Foundation

func fetchSuggestions(_ keyword: String) async -> [String] {
    do {
        let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: "https://event-search-react.wl.r.appspot.com/api/suggest?keyword=\(encodedKeyword)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        if (data.isEmpty) {
            return []
        }
        let suggestions = try JSONDecoder().decode([String].self, from: data)
        return suggestions
    } catch {
        print("Error fetching suggestons: \(error)")
    }
    
    return []
}
