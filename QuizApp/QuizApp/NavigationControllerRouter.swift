//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by lamha on 03/11/2022.
//

import UIKit
import QuizEngineX


protocol ViewControllerFactory {
    func questionViewController(for question: String, answerCallback: @escaping (String) -> Void) -> UIViewController
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
    
    func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
        let viewController = factory.questionViewController(for: question, answerCallback: answerCallback)
        navigationController.pushViewController(viewController, animated: true) // must be false or will crash or FakeNavi
    }
    
    func routeTo(result: Result<String, String>) {
        
    }
    
    
    
}
