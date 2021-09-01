//
//  AddQuestionTableViewCell.swift
//  MillionereGame
//
//  Created by Павел Черняев on 30.08.2021.
//

import UIKit

protocol QuestionCellDelegate: AnyObject {
    func setQuestionText(_ text: String, _ cell: UITableViewCell)
    func setAnswerText(_ text: String, _ cell: UITableViewCell, at answerIndex: Int)
    func selectCorrectAnswer(_ cell: UITableViewCell, at correctIndex: Int)
}

class AddQuestionTableViewCell: UITableViewCell {

    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet var answerGroupTextField: [UITextField]!
    @IBOutlet weak var correctAnswerSegmentControl: UISegmentedControl!
    weak var delegate: QuestionCellDelegate?
    static let reuseID = "QuestionCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        self.questionTextField.text = ""
        self.answerGroupTextField.forEach { $0.text = "" }
        self.correctAnswerSegmentControl.selectedSegmentIndex = 0
    }
    
    //MARK: - configure cell
    func configure(_ question: Question) {
        self.questionTextField.text = question.text
        for (index, answerTextField) in self.answerGroupTextField.enumerated() {
            let answer = question.answers[index]
            answerTextField.text = answer.text
            if answer.isCorrect {
                correctAnswerSegmentControl.selectedSegmentIndex = index
            }
        }
    }
    
    //MARK: - change Question
    @IBAction func changeQuestionTextField(_ sender: Any) {
        guard let questionTextField = sender as? UITextField else { return }
        guard let text = questionTextField.text else { return }
        self.delegate?.setQuestionText(text, self)
    }
    
    @IBAction func changeAnswerTextField(_ sender: Any) {
        guard let answerTextField = sender as? UITextField else { return }
        guard let text = answerTextField.text else { return }
        self.delegate?.setAnswerText(text, self, at: answerTextField.tag)
    }
    
    @IBAction func selectCorrectAnsweSegmetedContorol(_ sender: Any) {
        guard let segmentedControl = sender as? UISegmentedControl else { return }
        self.delegate?.selectCorrectAnswer(self, at: segmentedControl.selectedSegmentIndex)
    }
}
