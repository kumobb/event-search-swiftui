//
//  ArtistDetails.swift
//  EventSearch
//
//  Created by Desmond Wu on 4/22/23.
//

import Foundation

struct ArtistDetails: Identifiable, Codable {
    var id: String
    var name: String
    var followers: Int
    var popularity: Int
    var link: String
    var image: String?
    var albums: [String]
}

extension Int {
    var formatted: String {
        if self >= 1000000 {
            let millions = Double(self) / 1000000
            return String(format: "%.0fM", millions)
        } else if self >= 1000 {
            let thousands = Double(self) / 1000
            return String(format: "%.0fK", thousands)
        } else {
            return "\(self)"
        }
    }
}
