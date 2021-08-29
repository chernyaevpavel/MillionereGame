//
//  StartViewController.swift
//  MillionereGame
//
//  Created by Павел Черняев on 25.08.2021.
//

import UIKit

class StartViewController: UIViewController {
//    var game: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StartGame" {
            guard let vc = segue.destination as? GameViewController else { return }
            if Game.shared.gameSession == nil {
                let gameSession = GameSession()
                Game.shared.gameSession = gameSession
                vc.gameDelegate = gameSession
            } else {
                vc.gameDelegate = Game.shared.gameSession
            }
        }
    }

}

