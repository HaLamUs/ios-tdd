//
//  NavigationControllerRouterTest.swift
//  QuizAppTests
//
//  Created by lamha on 03/11/2022.
//

import Foundation
import XCTest
import QuizEngineX
@testable import QuizApp

class NavigationControllerRouterTest: XCTestCase {
    
    func test_answerForQuestions_showsQuestionControllers() {
       
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        factory.stub(question: singleAnswerQuestion, with: viewController)
        factory.stub(question: multipleAnswerQuestion, with: secondViewController)
    
        sut.answer(for: singleAnswerQuestion, completion: { _ in })
        sut.answer(for: multipleAnswerQuestion, completion: { _ in })

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    func test_answerForQuestion_singleAnwser_answerCallback_progressesToNextQuestion() {
        var callBackWasFired = false
        sut.answer(for: singleAnswerQuestion, completion: { _ in callBackWasFired = true })
        factory.answerCallback[singleAnswerQuestion]!(["anything"])
        XCTAssertTrue(callBackWasFired)
    }
    
    func test_answerQuestion_multipleAnwser_answerCallback_doesntProgressesToNextQuestion() {
        var callBackWasFired = false
        sut.answer(for: multipleAnswerQuestion, completion: { _ in callBackWasFired = true })
        factory.answerCallback[multipleAnswerQuestion]!(["anything"])
        
        XCTAssertFalse(callBackWasFired)
    }
    
    func test_answerQuestion_singleAnwser_doentConfigureViewControllerWithSubmitButton() {
        let viewController = UIViewController()
        factory.stub(question: singleAnswerQuestion, with: viewController)
        sut.answer(for: singleAnswerQuestion, completion: { _ in })
        XCTAssertNil(viewController.navigationItem.rightBarButtonItem)
    }
    
    func test_answerQuestion_multipleAnwser_configuresViewControllerWithSubmitButton() {
        let viewController = UIViewController()
        factory.stub(question: multipleAnswerQuestion, with: viewController)
        sut.answer(for: multipleAnswerQuestion, completion: { _ in })
        XCTAssertNotNil(viewController.navigationItem.rightBarButtonItem)
    }
    
    func test_answerQuestion_multipleAnwserSubmitButton_isDisableWhenZeroAnswerSelected() {
        let viewController = UIViewController()
        factory.stub(question: multipleAnswerQuestion, with: viewController)
        sut.answer(for: multipleAnswerQuestion, completion: { _ in })
        
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)
        
        factory.answerCallback[multipleAnswerQuestion]!(["anything"])
        XCTAssertTrue(viewController.navigationItem.rightBarButtonItem!.isEnabled)
        
        factory.answerCallback[multipleAnswerQuestion]!([])
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)
    }
    
    func test_answerQuestion_multipleAnwserSubmitButton_progressesToNextQuestion() {
        var callBackWasFired = false
        let viewController = UIViewController()
        factory.stub(question: multipleAnswerQuestion, with: viewController)
        sut.answer(for: multipleAnswerQuestion, completion: { _ in callBackWasFired = true })
        factory.answerCallback[multipleAnswerQuestion]!(["anything"])

        let button = viewController.navigationItem.rightBarButtonItem!
        button.simulateTap()
        
        XCTAssertTrue(callBackWasFired)
    }
    
    func test_didCompleteQuizk_showsResultControllers() {
        let viewController = UIViewController()
        let userAnswer = [(singleAnswerQuestion, ["A1"])]
        factory.stub(resultForQuestion: [singleAnswerQuestion], with: viewController)
        
        let secondViewController = UIViewController()
        let secondUserAnswers = [(multipleAnswerQuestion, ["A2"])]
        factory.stub(resultForQuestion: [multipleAnswerQuestion], with: secondViewController)
        
        sut.didCompleteQuiz(withAnswer: userAnswer)
        sut.didCompleteQuiz(withAnswer: secondUserAnswers)

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    // MARK: Helpers
    
    private let navigationController = NonAnimatedNavigationViewController()
    private let factory = ViewControllerFactoryStub()
    private let singleAnswerQuestion = Question.singleAnswer("Q1")
    private let multipleAnswerQuestion = Question.multipleAnswer("Q2")
    
    private lazy var sut: NavigationControllerRouter = {
        return NavigationControllerRouter(self.navigationController, factory: self.factory)
    }()
    
    private class NonAnimatedNavigationViewController: UINavigationController {
        
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }
    
    private class ViewControllerFactoryStub: ViewControllerFactory {
        
        private var stubbedQuestions = [Question<String>: UIViewController]()
        private var stubbedResults = [[Question<String>]: UIViewController]()
        var answerCallback = [Question<String>: ([String]) -> Void]()
        
        func resultViewController(for userAnswers: Answers) -> UIViewController {
            return stubbedResults[userAnswers.map{ $0.question }] ?? UIViewController()
        }
        
        func stub(question: Question<String>, with viewController: UIViewController) {
            stubbedQuestions[question] = viewController
        }
        
        func stub(resultForQuestion question: [Question<String>], with viewController: UIViewController) {
            stubbedResults[question] = viewController
        }
        
        func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
            self.answerCallback[question] = answerCallback
            return stubbedQuestions[question] ?? UIViewController() // incase you forgot stub (call stub method)
        }
        
    }
}
 

private extension UIBarButtonItem {
    func simulateTap() {
        target!.performSelector(onMainThread: action!, with: nil, waitUntilDone: true)
    }
}
