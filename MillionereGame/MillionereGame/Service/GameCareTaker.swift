//
//  GameCareTaker.swift
//  MillionereGame
//
//  Created by Павел Черняев on 29.08.2021.
//

import Foundation
class GameCareTaker {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private static let storageKey = "ResultGameKey"
    
    func save(_ resultsGame: [ResultGame]) {
        guard let data = try? encoder.encode(resultsGame) else { return }
        UserDefaults.standard.setValue(data, forKey: Self.storageKey)
    }
        
    func load() -> [ResultGame] {
        guard let data = UserDefaults.standard.value(forKey: Self.storageKey) as? Data else { return [] }
        return (try? decoder.decode([ResultGame].self, from: data)) ?? []
    }
    
}
