//
//  GameViewController.swift
//  MillionereGame
//
//  Created by Павел Черняев on 25.08.2021.
//

import UIKit

protocol GameVCDelegate: AnyObject {
    func useHint(_ hint: Hints)
    func getHints() -> [Hints]
    func endGame()
    func addCorrectAnswer()
    func getCorrectAnswer() -> Int
}

class GameViewController: UIViewController {
    @IBOutlet var btnAnswerGroup: [UIButton]!
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet var btnHelpGroup: [UIButton]!
    
    let questions = Questions.shared.questions
    var currentQuestion = 0
    private let letters = [0: "A", 1: "B", 2: "C", 3: "D"]
    let alertService = AlertService()
    weak var gameDelegate: GameVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let correctAnswer = self.gameDelegate?.getCorrectAnswer() {
            currentQuestion = correctAnswer
        }
        loadQueston(currentQuestion)
        lockHelpBtn()
    }
    
    //MARK: - обработка кнопок подсказок
    @IBAction func clickBtnHelpGroup(_ sender: Any) {
        var hint: Hints
        guard let btnHelp = sender as? UIButton else {
            print("Ошибка приведения типа кнопок подсказок")
            return
        }
        let tag = btnHelp.tag
        switch tag {
        case 0:
            hint = .callAFriend
        case 1:
            hint = .fiftyFifty
        case 2:
            hint = .helpAudience
        default:
            return
        }
        if !actionHelp(hint) { return }
        self.gameDelegate?.useHint(hint)
        disableBtn(btnHelp)
    }
    
    private func actionHelp(_ hint: Hints) -> Bool {
        switch hint {
        case .callAFriend:
            if let answer = Questions.shared.findCorrectAnswer(currentQuestion) {
                alertService.alertOK("Вариант друга", answer.text, self)
                return true
            } else {
                print("Ошибка поиска правильного варианта ответа")
                return false
            }
        case .fiftyFifty:
            var i = 2
            while i != 0 {
                let rnd = Int.random(in: 0...3)
                if questions[currentQuestion].answers[rnd].isCorrect { continue }
                if btnAnswerGroup[rnd].isHidden { continue }
                btnAnswerGroup[rnd].isHidden.toggle()
                i -= 1
            }
            return true
        case .helpAudience:
            guard let answer = Questions.shared.findCorrectAnswer(currentQuestion) else { return false}
            var percent = 100 - 69
            var message = """
                69% - \(answer.text)
                """
            var curPercent = Int(percent/2)
            for i in 0...3 {
                let item = questions[currentQuestion].answers[i]
                if item.isCorrect { continue }
                message += """
                    
                    \(curPercent)% - \(item.text)
                    """
                if i < 2 {
                    percent -= curPercent
                    curPercent = Int(percent/2)
                }
                
            }
            alertService.alertOK("Результат голосования зрителей:", message, self)
            return true
        }
    }
    
    //MARK: - блокировка кнопки помощи
    func lockHelpBtn() {
        guard let hints = self.gameDelegate?.getHints() else { return }
        for btnHelp in btnHelpGroup {
            let tag = btnHelp.tag
            switch tag {
            case 0:
                if !hints.contains(.callAFriend) { disableBtn(btnHelp) }
            case 1:
                if !hints.contains(.fiftyFifty) { disableBtn(btnHelp) }
            case 2:
                if !hints.contains(.helpAudience) { disableBtn(btnHelp) }
            default:
                return
            }
        }
    }
    
    private func disableBtn(_ btn: UIButton) {
        btn.isUserInteractionEnabled = false
        btn.tintColor = .red
    }
    
    //MARK: - загрузка вопросов и ответов
    private func loadQueston(_ questionNumber: Int) {
        if questionNumber >= questions.count {
            print("err")
            return
        }
        let question = questions[questionNumber]
        let answers = question.answers
        lblQuestion.text = question.text
        for btn in btnAnswerGroup {
            let tag = btn.tag
            guard let letter = letters[tag] else { return }
            if btn.isHidden {
                btn.isHidden.toggle()
            }
            btn.setTitle("\(letter): \(answers[tag].text)", for: .normal)
        }
    }
    
    //MARK: - обработка выбора ответа
    @IBAction func btnAnswerClick(_ sender: Any) {
        guard let btn = sender as? UIButton else { return }
        if questions[currentQuestion].answers[btn.tag].isCorrect {
            self.gameDelegate?.addCorrectAnswer()
            currentQuestion += 1
            loadQueston(currentQuestion)
        } else {
            //тут не плохо бы выкинуть alert, но не разобрался как обработать нажатие кнопки на alert и скрыть VC
            endGame()
        }
    }
    
    //MARK: - Завершить игру
    @IBAction func clickBtnEndGame(_ sender: Any) {
        endGame()
    }
    
    func endGame() {
        self.gameDelegate?.endGame()
        dismiss(animated: true, completion: nil)
    }
}
