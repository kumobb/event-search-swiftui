//
//  EventDetails.swift
//  EventSearch
//
//  Created by Desmond Wu on 4/21/23.
//

import Foundation

struct EventDetails: Identifiable, Codable {
    var id: String
    var name: String
    var date: String
    var artists: [Artist]?
    var venue: String
    var genre: [String]
    var price: String
    var status: String
    var link: String
    var map: String?
    
    struct Artist: Identifiable, Codable {
        var id: String {
            name
        }
        var name: String
        var segment: String
    }
}
