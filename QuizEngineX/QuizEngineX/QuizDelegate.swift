//
//  QuizDelegate.swift
//  QuizEngineX
//
//  Created by lamha on 07/12/2022.
//

import Foundation

public protocol QuizDelegate {
    associatedtype Answer
    associatedtype Question: Hashable
    
//    // asks the answer
//    func answer(for question: Question, completion: @escaping (Answer) -> Void)
//    func didCompleteQuiz(withAnswer: [(question: Question, answer: Answer)]) // array of tuple
    
    func answer(for question: Question, completion: @escaping (Answer) -> Void)
    func handle(result: ResultX<Question, Answer>)
    
    
    //    func handle(result: ResultX<Question, Answer>) <-- We remove ResultX cause it contains score
    // which the score is hardcode cause in survey dont have score
    // telling the anwer
}
