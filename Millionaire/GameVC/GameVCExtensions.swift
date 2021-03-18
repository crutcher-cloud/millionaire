//
//  GameVCExtensions.swift
//  Millionaire
//
//  Created by Влад Голосков on 20.02.2021.
//

import UIKit

extension GameViewController {
    func showEndGameAlert(title: String, message: String, buttonText: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: buttonText, style: .default, handler: {_ in
            //Закрытие текущего контроллера
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
