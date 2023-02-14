//
//  QuizDelegate.swift
//  fix-the-leak
//
//  Created by lamha on 14/02/2023.
//

import Foundation

public protocol QuizDelegate {
    associatedtype Answer
    associatedtype Question
    
    func answer(for question: Question, completion: @escaping (Answer) -> Void)
    func didCompleteQuiz(withAnswer: [(question: Question, answer: Answer)]) // array of tuple
}
