//
//  AlertService.swift
//  MillionereGame
//
//  Created by Павел Черняев on 25.08.2021.
//

import UIKit

class AlertService {
    func alertOK(_ title: String, _ message: String, _ vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
    }
    
    func alertError(_ title: String, _ message: String, _ vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
    }
}
