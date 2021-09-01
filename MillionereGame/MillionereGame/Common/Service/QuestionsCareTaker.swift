//
//  QuestionsCareTaker.swift
//  MillionereGame
//
//  Created by Павел Черняев on 31.08.2021.
//

import Foundation

class QuestionsCareTaker {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private static let key = "QuestionsCareTakerKey"
    
    func save(_ questions: [Question]) {
        guard let data = try? encoder.encode(questions) else { return }
        UserDefaults.standard.set(data, forKey: Self.key)
    }
    
    func load() -> [Question] {
        guard let data = UserDefaults.standard.data(forKey: Self.key) else { return [] }
        guard let questions = try? decoder.decode([Question].self, from: data) else { return [] }
        return questions
    }
}
