//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by lamha on 03/11/2022.
//

import UIKit
import QuizEngineX


protocol ViewControllerFactory {
    func questionViewController(for question: Question<String>, answerCallback: @escaping (String) -> Void) -> UIViewController
    
    func resultViewController(for result: ResultX<Question<String>, String>) -> UIViewController
}

/*
    Rule of thump the Router should be independent from controller
    Solve: Factory - Prototol
 */
class NavigationControllerRouter: Router {
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory
    
    init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func routeTo(question: Question<String>, answerCallback: @escaping (String) -> Void) {
        show(factory.questionViewController(for: question, answerCallback: answerCallback))
//        navigationController.pushViewController(viewController, animated: true) // must be false or will crash or FakeNavi
    }
    
    func routeTo(result: ResultX<Question<String>, String>) {
        show(factory.resultViewController(for: result))
        
    }
    
    private func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
