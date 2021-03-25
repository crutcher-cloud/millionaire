//
//  QuestionsCaretaker.swift
//  Millionaire
//
//  Created by Влад Голосков on 23.03.2021.
//

import Foundation

final class QuestionsCaretaker {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "questions"
    
    func saveQuestions(questions: [Question]) {
        do {
            let data = try self.encoder.encode(questions)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrieveQuestions() -> [Question] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return QuestionsStorage().arrayOfQuestions
        }
        do {
            return try self.decoder.decode([Question].self, from: data)
        } catch {
            print(error)
            return QuestionsStorage().arrayOfQuestions
        }
    }
    
}
