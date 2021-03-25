//
//  Singleton.swift
//  Millionaire
//
//  Created by Влад Голосков on 25.02.2021.
//

import Foundation

//Синглтон для хранения данных о текущей игре
class Game {
    static let shared = Game()
    
    private let resultsCaretaker = ResultsCaretaker()
    
    var session: GameSession?
    
    var highDifficulty: Bool = false //Хранение сложности. False - легко; True - сложно
    
    var results = [Records]() {
        didSet {
            resultsCaretaker.saveResults(results: results)
        }
    }
    
    private init() {
        self.results = self.resultsCaretaker.retrieveResults()
    }
    
    func calculationResult(result: GameSession) {
        //self.session?.percentOfTrue = (Double(result.correctAnswersCount) / Double(result.questionCount)) * 100
        Game.shared.results.append(Records(date: Date(), value: self.session!.percentOfTrue))
        self.session = nil
    }
}

//Модель текущей игровой сессии
class GameSession {
    var questionCount: Int = 0
    var correctAnswersCount: Int = 0
    var percentOfTrue = 0.0 {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "percentValueChanged"), object: nil)
        }
    }
}

//Модель вопроса
struct Question: Codable {
    var question = ""
    var answers = [String]()
    var correctAnswer = 0
}


//Модель записи о рекордах
struct Records: Codable {
    let date: Date
    let value: Double
}

