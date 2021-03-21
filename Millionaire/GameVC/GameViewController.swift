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
    
    var delegate: GameDelegate?
    
    //Экземпляр хранилища вопросов
    var questions = questionsStorage().arrayOfQuestions
    
    private var questionNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setQuestion(questionNumber: questionNumber)
        
        //Создание новой игровой сессии
        Game.shared.session = GameSession()
        Game.shared.session!.questionCount = questions.count
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
    
    func setQuestion(questionNumber: Int){
        titleLabel.text = "Вопрос \(questionNumber + 1) из \(questions.count)"
        questionLabel.text = questions[questionNumber].question
        
        for button in answerButtons {
            button.setTitle(questions[questionNumber].answers[button.tag], for: .normal)
        }
        
        self.questionNumber = questionNumber
    }
}

protocol GameDelegate {
    func didEndGame(with result: GameSession)
}
