//
//  Settings.swift
//  MillionereGame
//
//  Created by Павел Черняев on 29.08.2021.
//

import Foundation

struct Settings: Codable {
    private var shuffleQuestions: Bool = false
    
    mutating func setShuffleQuestions(_ shuffleQuestions: Bool) {
        self.shuffleQuestions = shuffleQuestions
    }
    
    func getShuffleQuestions() -> Bool {
        self.shuffleQuestions
    }
}
