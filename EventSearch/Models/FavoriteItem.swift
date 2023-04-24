//
//  FavoriteItem.swift
//  EventSearch
//
//  Created by Desmond Wu on 4/22/23.
//

import Foundation

struct FavoriteItem: Identifiable, Codable {
    var id: String
    var date: String
    var event: String
    var category: String
    var venue: String
}

class FavoritesData: ObservableObject {
    @Published var favoriteEvents: [FavoriteItem] = []

    static let saveKey = "FavoriteEvents"

    init() {
        load()
    }
    
    func isFavorite(eventId: String) -> Bool {
        return favoriteEvents.contains(where: { $0.id == eventId })
    }

    func add(event: FavoriteItem) {
        favoriteEvents.append(event)
        save()
    }

    func remove(eventId: String) {
        if let index = favoriteEvents.firstIndex(where: { $0.id == eventId}) {
            favoriteEvents.remove(at: index)
            save()
        }
    }

    private func save() {
        if let encodedData = try? JSONEncoder().encode(favoriteEvents) {
            UserDefaults.standard.set(encodedData, forKey: Self.saveKey)
        }
    }

    private func load() {
        if let data = UserDefaults.standard.data(forKey: Self.saveKey),
           let decodedData = try? JSONDecoder().decode([FavoriteItem].self, from: data) {
            self.favoriteEvents = decodedData
        }
    }
}
