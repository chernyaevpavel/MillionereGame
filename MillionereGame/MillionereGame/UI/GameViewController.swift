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
    func getCountCorrectAnswer() -> Int
    func addCurrentNumberQuestion()
    func getCurrentNumberQuestion() -> Int
}

class GameViewController: UIViewController {
    @IBOutlet var btnAnswerGroup: [UIButton]!
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet var btnHelpGroup: [UIButton]!
    @IBOutlet weak var currentQuestionLabel: UILabel!
    @IBOutlet weak var percentCorrectAnswerLabel: UILabel!
    var questions = [Question]()
    private let letters = [0: "A", 1: "B", 2: "C", 3: "D"]
    let alertService = AlertService()
    weak var gameDelegate: GameVCDelegate?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        Game.shared.gameSession?.percentCorrectAnswer.addObserver(self, options: [.new, .initial], closure: { [weak self] (percentCorrectAnswer, _) in
            let perentLabel = String(format: "%0.2f", percentCorrectAnswer)
            self?.percentCorrectAnswerLabel.text = "% правильных ответов: \(perentLabel)"
        })
        
        Game.shared.gameSession?.currentNumberQuestion.addObserver(self,options: [.initial, .new], closure: {[weak self] (curNumber, _) in
            self?.currentQuestionLabel.text = "Текущий вопрос: \(curNumber + 1)"
        })

        self.questions = getQuestions()
        showQueston(self.gameDelegate?.getCurrentNumberQuestion() ?? 0)
        disableHintsButtonsIfNeeded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Game.shared.gameSession?.percentCorrectAnswer.removeObserver(self)
        Game.shared.gameSession?.currentNumberQuestion.removeObserver(self)
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
        disableHintButton(btnHelp)
    }
    
    private func actionHelp(_ hint: Hints) -> Bool {
        switch hint {
        case .callAFriend:
            if let answer = Questions.shared.findCorrectAnswer(self.gameDelegate?.getCurrentNumberQuestion() ?? 0) {
                self.alertService.alertOK("Вариант друга", answer.text, self)
                return true
            } else {
                print("Ошибка поиска правильного варианта ответа")
                return false
            }
        case .fiftyFifty:
            var i = 2
            while i != 0 {
                let rnd = Int.random(in: 0...3)
                if questions[self.gameDelegate?.getCurrentNumberQuestion() ?? 0].answers[rnd].isCorrect { continue }
                if btnAnswerGroup[rnd].isHidden { continue }
                btnAnswerGroup[rnd].isHidden.toggle()
                i -= 1
            }
            return true
        case .helpAudience:
            guard let answer = Questions.shared.findCorrectAnswer(self.gameDelegate?.getCurrentNumberQuestion() ?? 0) else { return false}
            var percent = 100 - 69
            var message = """
                69% - \(answer.text)
                """
            var curPercent = Int(percent/2)
            for i in 0...3 {
                let item = questions[self.gameDelegate?.getCurrentNumberQuestion() ?? 0].answers[i]
                if item.isCorrect { continue }
                message += """
                    
                    \(curPercent)% - \(item.text)
                    """
                if i < 2 {
                    percent -= curPercent
                    curPercent = Int(percent/2)
                }
                
            }
            self.alertService.alertOK("Результат голосования зрителей:", message, self)
            return true
        }
    }
    
    //MARK: - блокировка кнопки помощи
    func disableHintsButtonsIfNeeded() {
        guard let hints = self.gameDelegate?.getHints() else { return }
        for btnHelp in btnHelpGroup {
            let tag = btnHelp.tag
            switch tag {
            case 0:
                if !hints.contains(.callAFriend) { disableHintButton(btnHelp) }
            case 1:
                if !hints.contains(.fiftyFifty) { disableHintButton(btnHelp) }
            case 2:
                if !hints.contains(.helpAudience) { disableHintButton(btnHelp) }
            default:
                return
            }
        }
    }
    
    private func disableHintButton(_ button: UIButton) {
        button.isUserInteractionEnabled = false
        button.tintColor = .red
    }
    
    //MARK: - загрузка вопросов и ответов
    private func getQuestions() -> [Question] {
        var shuffleStrategy: QuestionStrategy
        if Game.shared.getSettings().getShuffleQuestions() {
            shuffleStrategy = ShuffleQuestionStrategy()
        } else {
            shuffleStrategy = NoShuffleQuestionStrategy()
        }
        return shuffleStrategy.getQuestions()
    }
    
    private func showQueston(_ questionNumber: Int) {
        if questionNumber >= self.questions.count {
            print("err")
            return
        }
        let question = self.questions[questionNumber]
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
        let currentQuestion = self.gameDelegate?.getCurrentNumberQuestion() ?? 0
        if self.questions[currentQuestion].answers[btn.tag].isCorrect {
            if currentQuestion + 1 == self.questions.count {
                self.gameDelegate?.addCorrectAnswer()
                endGame()
                return
            }
            self.gameDelegate?.addCurrentNumberQuestion()
            self.gameDelegate?.addCorrectAnswer()
            showQueston(currentQuestion + 1)
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
