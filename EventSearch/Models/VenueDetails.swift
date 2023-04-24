//
//  VenueDetails.swift
//  EventSearch
//
//  Created by Desmond Wu on 4/22/23.
//

import Foundation

struct VenueDetails: Codable {
  var name: String
  var address: String?
  var number: String?
  var openHours: String?
  var generalRule: String?
  var childRule: String?
}
