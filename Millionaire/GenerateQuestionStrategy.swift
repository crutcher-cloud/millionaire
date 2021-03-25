//
//  GenerateQuestionStrategy.swift
//  Millionaire
//
//  Created by Влад Голосков on 21.03.2021.
//

import Foundation

protocol GenerateQuestionStrategy {
    func generateQuestion() -> [Question]
}

class StaticArrayOfQuestion: GenerateQuestionStrategy {
    private let questionsCaretaker = QuestionsCaretaker()
    
    func generateQuestion() -> [Question] {
        return questionsCaretaker.retrieveQuestions()
    }
}

class RandomArrayOfQuestion: GenerateQuestionStrategy {
    private let questionsCaretaker = QuestionsCaretaker()
    
    func generateQuestion() -> [Question] {
        return questionsCaretaker.retrieveQuestions().shuffled()
    }
}
