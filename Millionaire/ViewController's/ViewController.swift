//
//  ViewController.swift
//  Millionaire
//
//  Created by Влад Голосков on 20.02.2021.
//

import UIKit

class ViewController: UIViewController{
    
    @IBAction func playButtonTap(_ sender: UIButton) {
        let destinationVC = storyboard?.instantiateViewController(identifier: "GameViewController") as! GameViewController
        destinationVC.delegate = self
        present(destinationVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Game.shared.results)
    }
}

extension ViewController: GameDelegate {
    func didEndGame(with result: GameSession) {
        Game.shared.calculationResult(result: result)
    }
}




