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
        Questions.shared.questions.count
    }()
    private var countCorrectAnswer = 0
    var percentCorrectAnswer = Observable<Double>(0)
    var currentNumberQuestion = Observable<Int>(0)
}

extension GameSession: GameVCDelegate {
    
    //MARK: - правильный ответ
    func getCountCorrectAnswer() -> Int {
        countCorrectAnswer
    }

    func addCorrectAnswer() {
        countCorrectAnswer += 1
        let dblPercent = Double(countCorrectAnswer) / Double(countQuestion) * 100
        percentCorrectAnswer.value = dblPercent
    }
    
    //MARK: - завершить игру
    func endGame() {
        let result = Double(countCorrectAnswer) / Double(countQuestion) * 100
        let resultGame = ResultGame(result: result, date: Date())
        Game.shared.endGame(resultGame)
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
    
    //MARK: - текущий номер вопроса
    func addCurrentNumberQuestion() {
        currentNumberQuestion.value += 1
    }
    
    func getCurrentNumberQuestion() -> Int {
        currentNumberQuestion.value
    }
}
