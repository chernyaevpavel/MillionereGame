//
//  AddQuestionViewController.swift
//  MillionereGame
//
//  Created by Павел Черняев on 29.08.2021.
//

import UIKit

class AddQuestionViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let questionsBuilder = QuestionsBuilder()
    let questionsCareTaker = QuestionsCareTaker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.layoutIfNeeded()
    }
    
    @IBAction func clickAddQuestionButton(_ sender: Any) {
        questionsBuilder.addQuestion()
        tableView.reloadData()
    }
    
    @IBAction func addButtonClick(_ sender: Any) {
        let questions = questionsBuilder.build()
        if questions.isEmpty { return }
        questionsCareTaker.save(questions)
    }
}

extension AddQuestionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        questionsBuilder.getQuestionsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddQuestionTableViewCell.reuseID, for: indexPath) as? AddQuestionTableViewCell else { return UITableViewCell() }
        if let question = questionsBuilder.getQuestion(at: indexPath.row) {
            cell.configure(question)
            cell.delegate = self
        }
        return cell
    }
}

extension AddQuestionViewController: QuestionCellDelegate {
    
    func setQuestionText(_ text: String, _ cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        questionsBuilder.setQuestionText(text, at: indexPath.row)
    }
    
    func setAnswerText(_ text: String, _ cell: UITableViewCell, at answerIndex: Int) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        questionsBuilder.setAnswerText(text, at: indexPath.row, at: answerIndex)
    }
    
    func selectCorrectAnswer(_ cell: UITableViewCell, at correctIndex: Int) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        questionsBuilder.setCorrectAnswer(at: indexPath.row, at: correctIndex)
    }
}
