//
//  Questions.swift
//  MillionereGame
//
//  Created by Павел Черняев on 25.08.2021.
//

//Заглушка с вопросами и ответами
final class Questions {
    private init() {
        var questions = [Question]()
        //-----
        var answer1 = Answer("Дед мороз", true)
        var answer2 = Answer("Баба яга")
        var answer3 = Answer("Милиционер")
        var answer4 = Answer("Дириктор школы")
        var question = Question(text: "Кто приходит под Новый год к хорошим детям?", answers: [answer1, answer2, answer3, answer4])
        questions.append(question)
        //-----
        answer1 = Answer("Вилкой")
        answer2 = Answer("Ложкой", true)
        answer3 = Answer("Совочком")
        answer4 = Answer("Руками")
        question = Question(text: "Чем едят суп?", answers: [answer1, answer2, answer3, answer4])
        questions.append(question)
        //-----
        answer1 = Answer("Шарики", true)
        answer2 = Answer("Кубики")
        answer3 = Answer("Тюбики")
        answer4 = Answer("Зубики")
        question = Question(text: "Что чаще всего вешают на елку?", answers: [answer1, answer2, answer3, answer4])
        questions.append(question)
        //-----
        answer1 = Answer("Шишки")
        answer2 = Answer("Яблоки")
        answer3 = Answer("Желуди", true)
        answer4 = Answer("Златая цепь")
        question = Question(text: "Что растет на дубе?", answers: [answer1, answer2, answer3, answer4])
        questions.append(question)
        //-----
        answer1 = Answer("В пар")
        answer2 = Answer("В лед", true)
        answer3 = Answer("В газ")
        answer4 = Answer("В кисель")
        question = Question(text: "Во что превращается вода на морозе?", answers: [answer1, answer2, answer3, answer4])
        questions.append(question)
        //-----
        answer1 = Answer("В реке")
        answer2 = Answer("В озере")
        answer3 = Answer("В ухе")
        answer4 = Answer("В компоте", true)
        question = Question(text: "Где не бывает рыбы?", answers: [answer1, answer2, answer3, answer4])
        questions.append(question)
        //-----
        answer1 = Answer("На телевизор")
        answer2 = Answer("На эксковатор")
        answer3 = Answer("На вертолет", true)
        answer4 = Answer("На кухонный комбайн")
        question = Question(text: "На что похожа стрекоза?", answers: [answer1, answer2, answer3, answer4])
        questions.append(question)
        //-----
        answer1 = Answer("На венике")
        answer2 = Answer("На швабре")
        answer3 = Answer("На метле", true)
        answer4 = Answer("На пылесосе")
        question = Question(text: "На чем летает ведьма?", answers: [answer1, answer2, answer3, answer4])
        questions.append(question)
        //-----
        answer1 = Answer("Зеленкой", true)
        answer2 = Answer("Красненкой")
        answer3 = Answer("Белилкой")
        answer4 = Answer("Чернилкой")
        question = Question(text: "Чем мажут царапины?", answers: [answer1, answer2, answer3, answer4])
        questions.append(question)
        //-----
        answer1 = Answer("Зажечь")
        answer2 = Answer("Задуть", true)
        answer3 = Answer("Съесть")
        answer4 = Answer("Разрезать")
        question = Question(text: "Что должен сделать именниник со свечками на торте?", answers: [answer1, answer2, answer3, answer4])
        questions.append(question)
        //-----
        self.questions = questions
        
    }
    static let shared = Questions()
    let questions: [Question]
    
    func findCorrectAnswer(_ questionNumber: Int) -> Answer? {
        if questions.count < (questionNumber - 1) {
            return nil
        }
        let question = questions[questionNumber]
        return question.answers.first(where: {$0.isCorrect})
    }
}
