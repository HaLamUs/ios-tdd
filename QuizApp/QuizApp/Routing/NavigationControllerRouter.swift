//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by lamha on 03/11/2022.
//

import UIKit
import QuizEngineX
/*
    Rule of thump the Router should be independent from controller
    Solve: Factory - Prototol
 */
final class NavigationControllerRouter: QuizDelegate {
    
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory
    
    init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func answer(for question: Question<String>, completion: @escaping ([String]) -> Void) {
        switch question {
        case .singleAnswer:
            show(factory.questionViewController(for: question, answerCallback: completion))
        case .multipleAnswer:
            let button = UIBarButtonItem(title: "Submit", style: .done, target: nil, action: nil)
            let buttonController = SubmitButtonController(button, completion)
            let controller = factory.questionViewController(for: question, answerCallback: { selection in
                buttonController.update(model: selection)
            })
            
            controller.navigationItem.rightBarButtonItem = button
            show(controller)
        }
    }
    
    func didCompleteQuiz(withAnswer answers: [(question: Question<String>, answer: [String])]) {
        show(factory.resultViewController(for: answers)) 
    }
    
    private func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

private class SubmitButtonController: NSObject {
    let button: UIBarButtonItem
    let callback: ([String]) -> Void
    private var model = [String]()
    
    init(_ button: UIBarButtonItem, _ callback: @escaping ([String]) -> Void) {
        self.button = button
        self.callback = callback
        super.init() // <-- need in this pos
        self.setup()
    }
    
    private func setup() {
        button.target = self
        button.action = #selector(fireCallback)
        updateButtonState()
    }
    
    func update(model: [String]) {
        self.model = model
        updateButtonState()
    }
    
    private func updateButtonState() {
        button.isEnabled = model.count > 0
    }
    
    @objc private func fireCallback() {
        callback(model)
    }
    
}
