//
//  QuizDelegate.swift
//  QuizEngineX
//
//  Created by lamha on 07/12/2022.
//

import Foundation

public protocol QuizDelegate {
    associatedtype Answer
    associatedtype Question
    
    func answer(for question: Question, completion: @escaping (Answer) -> Void)
    func didCompleteQuiz(withAnswer: [(question: Question, answer: Answer)]) // array of tuple
}
