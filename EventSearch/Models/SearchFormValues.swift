//
//  SearchFormValues.swift
//  EventSearch
//
//  Created by Desmond Wu on 4/4/23.
//

import Foundation

struct SearchFormValues {
    var keyword = ""
    var distance = "10"
    var category = "Default"
    var location = ""
    var autoDetect = false
    
    var isFilled:Bool {
        !keyword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !distance.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        (autoDetect || !location.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }
    
    mutating func reset() {
        keyword = ""
        distance = "10"
        category = "Default"
        location = ""
        autoDetect = false
    }
    
}
