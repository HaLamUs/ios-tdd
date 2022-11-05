//
//  iOSViewControllerFactory.swift
//  QuizAppTests
//
//  Created by lamha on 05/11/2022.
//

import UIKit
import QuizEngineX

class iOSViewControllerFactory: ViewControllerFactory {
    
    private let options: [Question<String>: [String]]
    
    init(options: [Question<String>: [String]]) {
        self.options = options
    }
    
    func resultViewController(for result: ResultX<Question<String>, [String]>) -> UIViewController {
        UIViewController()
    }
    
    func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
        switch question {
            case .singleAnswer(let value):
                return QuestionViewController(question: value, options: options[question]!, selection: answerCallback)
            default:
                return UIViewController()
        }
    }
}
