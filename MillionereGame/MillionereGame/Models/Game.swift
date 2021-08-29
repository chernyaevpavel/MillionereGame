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
    }
    
    static let shared = Game()
    var gameSession: GameSession?
    private let gameCareTaker: GameCareTaker
    var resultsGame: [ResultGame]
    
    
    func endGame(_ resultGame: ResultGame) {
        resultsGame.append(resultGame)
        gameCareTaker.save(self.resultsGame)
    }
}
