//
//  AddQuestionsVCExtensions.swift
//  Millionaire
//
//  Created by Влад Голосков on 23.03.2021.
//

import UIKit

extension AddQuestionViewController {
    func showAlert(title: String, message: String, buttonText: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: buttonText, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
