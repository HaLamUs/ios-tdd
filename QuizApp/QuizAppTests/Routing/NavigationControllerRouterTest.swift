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
    
    let navigationController = NonAnimatedNavigationViewController()
    let factory = ViewControllerFactoryStub()
    //ONly in callback you can ref to factory and navi
    lazy var sut: NavigationControllerRouter = {
        return NavigationControllerRouter(self.navigationController, factory: self.factory)
    }()
    
    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q2")
    
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
    
    func test_routeToResults_showsResultControllers() {
        let viewController = UIViewController()
        let result = ResultX.make(answers: [singleAnswerQuestion: ["A1"]], score: 1)
        factory.stub(result: result, with: viewController)
        
        let secondViewController = UIViewController()
        let secondResult = ResultX.make(answers: [multipleAnswerQuestion: ["A2"]], score: 12)
        factory.stub(result: secondResult, with: secondViewController)
        
        sut.routeTo(result: result)
        sut.routeTo(result: secondResult)

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    class NonAnimatedNavigationViewController: UINavigationController {
        
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }
    
    //fake
    class ViewControllerFactoryStub: ViewControllerFactory {
        
        private var stubbedQuestions = [Question<String>: UIViewController]()
        private var stubbedResults = [ResultX<Question<String>, [String]>: UIViewController]()
        var answerCallback = [Question<String>: ([String]) -> Void]()
        
        func resultViewController(for userAnswers: Answers) -> UIViewController {
            UIViewController()
        }
        
        func stub(question: Question<String>, with viewController: UIViewController) {
            stubbedQuestions[question] = viewController
        }
        
        func stub(result: ResultX<Question<String>, [String]>, with viewController: UIViewController) {
            stubbedResults[result] = viewController
        }
        
        func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
            self.answerCallback[question] = answerCallback
            return stubbedQuestions[question] ?? UIViewController() // incase you forgot stub (call stub method)
        }
        
        func resultViewController(for result: ResultX<Question<String>, [String]>) -> UIViewController {
            return stubbedResults[result] ?? UIViewController() // incase you
        }
    }
}
 

private extension UIBarButtonItem {
    func simulateTap() {
        target!.performSelector(onMainThread: action!, with: nil, waitUntilDone: true)
    }
}
