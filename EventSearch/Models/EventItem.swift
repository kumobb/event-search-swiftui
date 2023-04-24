//
//  EventItem.swift
//  EventSearch
//
//  Created by Desmond Wu on 4/21/23.
//

import Foundation

struct EventItem: Identifiable, Codable {
    let id: String
    let date: String
    let time: String?
    let image: String
    let event: String
    let venue: String
}
