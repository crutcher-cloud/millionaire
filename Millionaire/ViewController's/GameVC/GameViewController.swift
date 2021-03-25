//
//  GameViewController.swift
//  Millionaire
//
//  Created by Влад Голосков on 20.02.2021.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    
    @IBOutlet weak var percentLabel: UILabel!
    
    var delegate: GameDelegate?
    
    //Экземпляр хранилища вопросов
    var questions = [Question]()
    
    var questionNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Создание новой игровой сессии
        Game.shared.session = GameSession()
        Game.shared.session!.questionCount = questions.count
        
        //Выбор стратегии в зависимости от установленного уровня сложности
        switch Game.shared.highDifficulty {
        case false:
            questions = StaticArrayOfQuestion().generateQuestion()
        default:
            questions = RandomArrayOfQuestion().generateQuestion()
        }
        
        //Установка 1го вопроса
        setQuestion(questionNumber: questionNumber)
        
        //Подписка на изменения percentOfTrue
        NotificationCenter.default.addObserver(self, selector: #selector(notificationAction), name: NSNotification.Name(rawValue: "percentValueChanged"), object: nil)
    }
    
    @objc func notificationAction() {
        percentLabel.text = "Пройдено: \(Int(Game.shared.session?.percentOfTrue.rounded() ?? 0.0))%"
    }
    
    @IBAction func endButtonTap(_ sender: UIButton) {
        delegate?.didEndGame(with: Game.shared.session!)
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func answerButtonDidTap(_ sender: UIButton) {
        if sender.tag == questions[questionNumber].correctAnswer {
            if (questionNumber + 1) < questions.count {
                setQuestion(questionNumber: questionNumber + 1)
                Game.shared.session!.correctAnswersCount += 1
                Game.shared.session?.percentOfTrue = (Double(Game.shared.session!.correctAnswersCount) / Double(self.questions.count)) * 100
            } else {
                Game.shared.session!.correctAnswersCount += 1
                showEndGameAlert(title: "Игра закончена", message: "Вы правильно ответили на все вопросы!", buttonText: "ОК")
                delegate?.didEndGame(with: Game.shared.session!)
                //Закрытие контроллера GameViewController происходит по нажатию кнопки "ОК" в алерте
            }
        } else {
            showEndGameAlert(title: "Игра закончена", message: "Ответ неверный :(", buttonText: "ОК")
            delegate?.didEndGame(with: Game.shared.session!)
            //Закрытие контроллера GameViewController происходит по нажатию кнопки "ОК" в алерте
        }
    }
}

protocol GameDelegate {
    func didEndGame(with result: GameSession)
}
