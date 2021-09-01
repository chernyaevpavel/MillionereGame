//
//  QuestionsBuilder.swift
//  MillionereGame
//
//  Created by Павел Черняев on 30.08.2021.
//

class QuestionsBuilder {
    private var questions = [Question]()
    private let questionBuilder = QuestionBuilder()
    
    //MARK: - for tableView on UIViewController
    func getQuestionsCount() -> Int {
        self.questions.count
    }
    
    func getQuestion(at index: Int) -> Question? {
        self.questions[index]
    }
    
    func addQuestion() {
        self.questions.append(questionBuilder.build())
    }
    
    //MARK: - builder
    func build() -> [Question] {
        return self.questions.filter { !$0.text.isEmpty && $0.answers.filter({!$0.text.isEmpty}).count == 4 }
    }
    
    func setQuestionText(_ text: String, at index: Int) {
        if index >= self.questions.count { return }
        self.questions[index].text = text
    }
    
    func setAnswerText(_ text: String, at indexQuestion: Int, at indexAnswer: Int) {
        if indexQuestion >= self.questions.count || indexAnswer > 3 { return }
        self.questions[indexQuestion].answers[indexAnswer].text = text
    }
    
    func setCorrectAnswer(at indexQuestion: Int, at correctIndex: Int) {
        if indexQuestion >= self.questions.count { return }
        for i in 0...3 {
            self.questions[indexQuestion].answers[i].isCorrect = i == correctIndex ? true : false
        }
    }
}
