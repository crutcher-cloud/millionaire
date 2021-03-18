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
    private var gameSession = GameSession()
    
    private var questionNumber = 0
    
    private var arrayOfQuestions = [
        Question(question: "Какое растение существует на самом деле?", answers: ["Лох чилийский", "Лох индийский", "Лох русский", "Лох греческий"], correctAnswer: 1),
        Question(question: "Что за место, попав в которое, человек делает селфи на кухне, которую не может себе позволить?", answers: ["Рим", "Париж", "Лондон", "Икеа"], correctAnswer: 3),
        Question(question: "Какой город объявлен официальной родиной русского Деда Мороза?", answers: ["Малая Вишера", "Великий Устюг", "Вышний Волочек", "Нижний Новгород"], correctAnswer: 1),
        Question(question: "Что проводит боксер, наносящий удар противнику снизу?", answers: ["Свинг", "Хук", "Апперкот", "Джеб"], correctAnswer: 2),
        Question(question: "К кому первому обратились за помощью дед и бабка, не справившись с репкой?", answers: ["К Жучке", "К дочке", "К внучке", "К залу"], correctAnswer: 2),
        Question(question: "Кого нет среди смешариков?", answers: ["Барана", "Свиньи", "Коня", "Лося"], correctAnswer: 2),
        Question(question: "Как называется ближайшая к Земле звезда?", answers: ["Проксиома Центавра", "Солнце", "Полярная", "Сириус"], correctAnswer: 1),
        Question(question: "Что помогает запомнить мнемоническое правило «Это я знаю и помню прекрасно»?", answers: ["Число Пи", "Ряд активности металлов", "Цвета радуги", "Порядок падежей"], correctAnswer: 0),
        Question(question: "Какую площадь имеет клетка стандартной школьной тетради?", answers: ["0.25 кв.см", "1 кв.см", "0.5 кв.см", "1.25 кв. см"], correctAnswer: 0),
        Question(question: "Что происходит на соревнованиях по стрельбе, если соперники набрали одинаковое количество очков?", answers: ["Перевербовка", "Перепалка", "Перебранка", "Перестрелка"], correctAnswer: 3)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setQuestion(questionNumber: questionNumber)
        
        gameSession.questionCount = arrayOfQuestions.count
    }
    
    @IBAction func endButtonTap(_ sender: UIButton) {
        delegate?.didEndGame(with: gameSession)
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func answerButtonDidTap(_ sender: UIButton) {
        if sender.tag == arrayOfQuestions[questionNumber].correctAnswer {
            if (questionNumber + 1) < arrayOfQuestions.count {
                setQuestion(questionNumber: questionNumber + 1)
                gameSession.correctAnswersCount += 1
            } else {
                gameSession.correctAnswersCount += 1
                showEndGameAlert(title: "Игра закончена", message: "Вы правильно ответили на все вопросы!", buttonText: "ОК")
                delegate?.didEndGame(with: gameSession)
                //Закрытие контроллера GameViewController происходит по нажатию кнопки "ОК" в алерте
            }
        } else {
            showEndGameAlert(title: "Игра закончена", message: "Ответ неверный :(", buttonText: "ОК")
            delegate?.didEndGame(with: gameSession)
            //Закрытие контроллера GameViewController происходит по нажатию кнопки "ОК" в алерте
        }
    }
    
    func setQuestion(questionNumber: Int){
        titleLabel.text = "Вопрос \(questionNumber + 1) из \(arrayOfQuestions.count)"
        questionLabel.text = arrayOfQuestions[questionNumber].question
        
        for button in answerButtons {
            button.setTitle(arrayOfQuestions[questionNumber].answers[button.tag], for: .normal)
        }
        
        self.questionNumber = questionNumber
    }
}

protocol GameDelegate {
    func didEndGame(with result: GameSession)
}
