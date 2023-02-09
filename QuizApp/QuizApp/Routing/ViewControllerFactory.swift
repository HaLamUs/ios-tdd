//
//  ViewControllerFactory.swift
//  QuizApp
//
//  Created by lamha on 05/11/2022.
//

import UIKit
import QuizEngineX

protocol ViewControllerFactory {
    typealias Answers = [(question: Question<String>, answers: [String])]
    
    func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController
    
    func resultViewController(for userAnswers: Answers) -> UIViewController
    
    func resultViewController(for result: ResultX<Question<String>, [String]>) -> UIViewController
}

