//
//  QuestionStrategy.swift
//  MillionereGame
//
//  Created by Павел Черняев on 29.08.2021.
//

import Foundation

protocol QuestionStrategy {
    func getQuestions() -> [Question]
}

class ShuffleQuestionStrategy: QuestionStrategy {
    func getQuestions() -> [Question] {
        Questions.shared.questions.shuffled()
    }
}

class NoShuffleQuestionStrategy: QuestionStrategy {
    func getQuestions() -> [Question] {
        Questions.shared.questions
    }
}
