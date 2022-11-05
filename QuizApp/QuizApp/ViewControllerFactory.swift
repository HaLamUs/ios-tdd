//
//  ViewControllerFactory.swift
//  QuizApp
//
//  Created by lamha on 05/11/2022.
//

import UIKit
import QuizEngineX

protocol ViewControllerFactory {
    func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController
    
    func resultViewController(for result: ResultX<Question<String>, [String]>) -> UIViewController
}

