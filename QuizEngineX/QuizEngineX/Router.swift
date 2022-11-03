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
public protocol Router {
    associatedtype Answer
    associatedtype Question: Hashable // why because question used as a key in dict
    
    func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void)
    func routeTo(result: Result<Question, Answer>)
}
