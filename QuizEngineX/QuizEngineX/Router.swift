//
//  Router.swift
//  QuizEngineX
//
//  Created by lamha on 03/11/2022.
//

import Foundation

/*
 It's a contract that change depend on platform
 */
@available(*, deprecated)
public protocol Router {
    associatedtype Answer
    associatedtype Question: Hashable // why because question used as a key in dict
    
    func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void)
    func routeTo(result: ResultX<Question, Answer>)
}

public protocol QuizDelegate {
    associatedtype Answer
    associatedtype Question: Hashable
    
    func handle(question: Question, answerCallback: @escaping (Answer) -> Void)
    func handle(result: ResultX<Question, Answer>)
}
