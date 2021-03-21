//
//  ResultsCaretaker.swift
//  Millionaire
//
//  Created by Влад Голосков on 17.03.2021.
//

import Foundation

final class ResultsCaretaker {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "results"
    
    func saveResults(results: [Records]) {
        do {
            let data = try self.encoder.encode(results)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrieveResults() -> [Records] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try self.decoder.decode([Records].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
    
}
