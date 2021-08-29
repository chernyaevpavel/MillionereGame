//
//  ResultsViewController.swift
//  MillionereGame
//
//  Created by Павел Черняев on 29.08.2021.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    static let cellReuseID = "RsultGameReuseID"

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


extension ResultsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Game.shared.resultsGame.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: Self.cellReuseID, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let resultGame = Game.shared.resultsGame[indexPath.row]
        cell.textLabel?.text = DateFormatter.localizedString(from: resultGame.date, dateStyle: .medium, timeStyle: .medium)
        cell.detailTextLabel?.text = String(format: "%.02f", resultGame.result) + "%"
    }
}
