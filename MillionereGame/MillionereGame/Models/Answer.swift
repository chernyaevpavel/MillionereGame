//
//  Answer.swift
//  MillionereGame
//
//  Created by Павел Черняев on 25.08.2021.
//

import Foundation

struct Answer: Codable {
    var text: String
    var isCorrect: Bool
    
    init(_ answer: String, _ isCorrect: Bool = false) {
        self.text = answer
        self.isCorrect = isCorrect
    }
}
