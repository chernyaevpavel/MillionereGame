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
    private static let storageSettingsKey = "SettingsGameKey"
    
    func save(_ resultsGame: [ResultGame]) {
        guard let data = try? encoder.encode(resultsGame) else { return }
        UserDefaults.standard.setValue(data, forKey: Self.storageKey)
    }
        
    func load() -> [ResultGame] {
        guard let data = UserDefaults.standard.value(forKey: Self.storageKey) as? Data else { return [] }
        return (try? decoder.decode([ResultGame].self, from: data)) ?? []
    }
    
    func saveSettings(_ settings: Settings){
        guard let data = try? encoder.encode(settings) else { return }
        UserDefaults.standard.setValue(data, forKey: Self.storageSettingsKey)
    }
    
    func loadSettings() -> Settings? {
        guard let data = UserDefaults.standard.value(forKey: Self.storageSettingsKey) as? Data else { return nil }
        return (try? decoder.decode(Settings.self, from: data)) ?? nil
    }
}
