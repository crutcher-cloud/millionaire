//
//  Singleton.swift
//  Millionaire
//
//  Created by Влад Голосков on 25.02.2021.
//

import Foundation

class Game {
    static let shared = Game()
    
    private let resultsCaretaker = ResultsCaretaker()
    
    var session: GameSession?
    var results: [Records] = [] {
        didSet {
            resultsCaretaker.saveResults(results: results)
        }
    }
    
    private init() {
        self.results = self.resultsCaretaker.retrieveResults()
    }
    
    func calculationResult(result: GameSession) {
        let percent = (Double(result.correctAnswersCount) / Double(result.questionCount)) * 100
        Game.shared.results.append(Records(date: Date(), value: percent))
        self.session = nil
    }
}

class GameSession {
    var questionCount: Int = 0
    var correctAnswersCount: Int = 0
}

struct Records: Codable {
    let date: Date
    let value: Double
}

