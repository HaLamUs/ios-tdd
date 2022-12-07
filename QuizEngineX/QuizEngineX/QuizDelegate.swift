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
    
    func handle(question: Question, answerCallback: @escaping (Answer) -> Void)
    func handle(result: ResultX<Question, Answer>)
}
