//
//  GameSession.swift
//  MillionereGame
//
//  Created by Павел Черняев on 25.08.2021.
//

import UIKit

class GameSession {
    var hints: [Hints] = [.callAFriend, .fiftyFifty, .helpAudience]
    private let countQuestion = {
        Questions.shared.questions.count + 1
    }()
    private var countCorrectAnswer = 0
}

extension GameSession: GameVCDelegate {
    //MARK: - правильный ответ
    func getCorrectAnswer() -> Int {
        countCorrectAnswer
    }
    
    func addCorrectAnswer() {
        countCorrectAnswer += 1
    }
    
    //MARK: - завершить игру
    func endGame() {
        let result = Double(countCorrectAnswer) / Double(countQuestion) * 100
        let resultGame = ResultGame(result: result, date: Date())
        Game.shared.endGame(resultGame)
        Game.shared.gameSession = nil
    }
    
    //MARK: - подсказки
    func useHint(_ hint: Hints) {
        guard let index = hints.firstIndex(of: hint) else { return }
        hints.remove(at: index)
        return
    }
    
    func getHints() -> [Hints] {
        hints
    }
}
