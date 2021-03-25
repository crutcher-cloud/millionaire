//
//  AddQuestionViewController.swift
//  Millionaire
//
//  Created by Влад Голосков on 22.03.2021.
//

import UIKit

class AddQuestionViewController: UIViewController {
    
    private let questionsCaretaker = QuestionsCaretaker()
    private var arrayOfQuestions = QuestionsStorage().arrayOfQuestions
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var firstAnswer: UITextField!
    @IBOutlet weak var secondAnswer: UITextField!
    @IBOutlet weak var thirdAnswer: UITextField!
    @IBOutlet weak var forthAnswer: UITextField!
    @IBOutlet weak var correctAnswer: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        questionTextView.layer.borderWidth = 0.5
        questionTextView.layer.borderColor = .init(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        questionTextView.layer.cornerRadius = 0.5
    }
    
    @IBAction func cancelButtonTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func saveButtonTap(_ sender: UIButton) {
        if emptyCheck() {
            arrayOfQuestions.append(.init(question: questionTextView.text, answers: [firstAnswer.text!, secondAnswer.text!, thirdAnswer.text!, forthAnswer.text!], correctAnswer: Int(correctAnswer.text ?? "1")! - 1))
            questionsCaretaker.saveQuestions(questions: arrayOfQuestions)
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    func emptyCheck() -> Bool {
        if (questionTextView.text.isEmpty ||
                firstAnswer.text!.isEmpty ||
                secondAnswer.text!.isEmpty ||
                thirdAnswer.text!.isEmpty ||
                forthAnswer.text!.isEmpty ||
                correctAnswer.text!.isEmpty) {
            showAlert(title: "Ошибка", message: "Необходимо заполнить все поля", buttonText: "OK")
            return false
        }
        return true
    }
}
