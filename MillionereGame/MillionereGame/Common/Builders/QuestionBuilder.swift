//
//  QuestionBuilder.swift
//  MillionereGame
//
//  Created by Павел Черняев on 30.08.2021.
//

import Foundation

enum QuestionBuilderError: Error {
    case ErrAnswerIndex
}

class QuestionBuilder {
    private(set) var questionText = ""
    private(set) var answers: [Answer] = {
        var arr = [Answer]()
        for _ in 0...3 {
            arr.append(Answer(""))
        }
        arr[0].isCorrect = true
        return arr
    }()
    
    func build() -> Question {
        return Question(text: questionText, answers: answers)
    }
    
    func setQuestionText(_ text: String) -> Self {
        self.questionText = text
        return self
    }
    
    func setAnswerText(at answerIndex: Int, _ text: String) throws -> Self {
        if answerIndex >= self.answers.count {
            throw QuestionBuilderError.ErrAnswerIndex
        }
        self.answers[answerIndex].text = text
        return self
    }
    
    func setCorrectAnswer(at answerIndex: Int) throws -> Self {
        if answerIndex >= self.answers.count {
            throw QuestionBuilderError.ErrAnswerIndex
        }
        for (index, _) in self.answers.enumerated() {
            self.answers[index].isCorrect = index == answerIndex ? true : false
        }
        return self
    }
}
