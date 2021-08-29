//
//  Answer.swift
//  MillionereGame
//
//  Created by Павел Черняев on 25.08.2021.
//

import Foundation

struct Answer {
    let text: String
    let isCorrect: Bool
    
    init(_ answer: String, _ isCorrect: Bool) {
        self.text = answer
        self.isCorrect = isCorrect
    }
    
    init(_ answer: String) {
        self.text = answer
        self.isCorrect = false
    }
}
