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
        guard let option = options[question] else {
            fatalError("Could not find options for question \(question)")
        }
        return questionViewController(for: question, option: option, answerCallback: answerCallback)
    }
    
    private func questionViewController(for question: Question<String>, option: [String], answerCallback: @escaping ([String]) -> Void) -> UIViewController {
        switch question {
            case .singleAnswer(let value):
                return QuestionViewController(question: value,
                                              options: option,
                                              selection: answerCallback)
        case .multipleAnswer(let value):
            let controller = QuestionViewController(question: value,
                                          options: option,
                                          selection: answerCallback)
            _ = controller.view
            controller.tableView.allowsMultipleSelection = true
            return controller
        }

    }
}
