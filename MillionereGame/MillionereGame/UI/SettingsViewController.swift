//
//  SettingsViewController.swift
//  MillionereGame
//
//  Created by Павел Черняев on 29.08.2021.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var shuffleQuestionsSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shuffleQuestionsSwitch.isOn = Game.shared.getSettings().getShuffleQuestions()
    }
    
    
    @IBAction func changeShuffleQuestionsSwitch(_ sender: Any) {
        guard let shuffleSwitch = sender as? UISwitch else { return }
        Game.shared.changeSettingsShuffleQuestions(shuffleSwitch.isOn)
    }
}
