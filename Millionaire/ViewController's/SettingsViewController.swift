//
//  SettingsViewController.swift
//  Millionaire
//
//  Created by Влад Голосков on 21.03.2021.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        difficultySwitcher.isOn = Game.shared.highDifficulty
    }
    
    @IBOutlet weak var difficultySwitcher: UISwitch!
    
    @IBAction func switcherChanged(_ sender: UISwitch) {
        
        //Задание сложности:
        //Низкий уровень = false
        //Высокий уровень = true
        Game.shared.highDifficulty = !Game.shared.highDifficulty
    }
    
    @IBAction func saveButtonTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
