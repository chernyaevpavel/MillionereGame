//
//  Question.swift
//  MillionereGame
//
//  Created by Павел Черняев on 25.08.2021.
//

import Foundation

struct Question: Codable {
    var text: String
    var answers: [Answer]
}
