//
//  Game.swift
//  MillionereGame
//
//  Created by Павел Черняев on 25.08.2021.
//
import Foundation

final class Game {
    private init() {
        self.gameCareTaker = GameCareTaker()
        self.resultsGame = self.gameCareTaker.load()
        if let settings = self.gameCareTaker.loadSettings() {
            self.settings = settings
        } else {
            let settings = Settings()
            self.settings = settings
            self.gameCareTaker.saveSettings(settings)
        }
    }
    
    static let shared = Game()
    var gameSession: GameSession?
    private let gameCareTaker: GameCareTaker
    var resultsGame: [ResultGame]
    private var settings: Settings
    
    func endGame(_ resultGame: ResultGame) {
        resultsGame.append(resultGame)
        gameCareTaker.save(self.resultsGame)
        self.gameSession = nil
    }
    
    func changeSettingsShuffleQuestions(_ shuffleSettings: Bool) {
        self.settings.setShuffleQuestions(shuffleSettings)
        self.gameCareTaker.saveSettings(self.settings)
    }
    
    func getSettings() -> Settings {
        self.settings
    }
    
}

