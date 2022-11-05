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
    lazy var sut:NavigationControllerRouter = {
        return NavigationControllerRouter(self.navigationController, factory: self.factory)
    }()
    
    func test_routeToQuestions_showsQuestionControllers() {
       
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        factory.stub(question: Question.singleAnswer("Q1"), with: viewController)
        factory.stub(question: Question.singleAnswer("Q2"), with: secondViewController)
    
        sut.routeTo(question: Question.singleAnswer("Q1"), answerCallback: { _ in })
        sut.routeTo(question: Question.singleAnswer("Q2"), answerCallback: { _ in })

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    func test_routeQuestion_presentsQuestionControllerWithRightCallback() {
        var callBackWasFired = false
        sut.routeTo(question: Question.singleAnswer("Q1"), answerCallback: { _ in callBackWasFired = true })
        factory.answerCallback[Question.singleAnswer("Q1")]!("anything")

        XCTAssertEqual(navigationController.viewControllers.count, 1)
        
        XCTAssertEqual(callBackWasFired, true)
    }
    
    func test_routeToResults_showsResultControllers() {
        let viewController = UIViewController()
        let result = ResultX(answers: [Question.singleAnswer("Q1"): "A1"], score: 1)
        factory.stub(result: result, with: viewController)
        
        let secondViewController = UIViewController()
        let secondResult = ResultX(answers: [Question.singleAnswer("Q2"): "A2"], score: 12)
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
        private var stubbedResults = [ResultX<Question<String>,String>: UIViewController]()
        var answerCallback = [Question<String>: (String) -> Void]()
        
        
        func stub(question: Question<String>, with viewController: UIViewController) {
            stubbedQuestions[question] = viewController
        }
        
        func stub(result: ResultX<Question<String>, String>, with viewController: UIViewController) {
            stubbedResults[result] = viewController
        }
        
        func questionViewController(for question: Question<String>, answerCallback: @escaping (String) -> Void) -> UIViewController {
            self.answerCallback[question] = answerCallback
            return stubbedQuestions[question] ?? UIViewController() // incase you forgot stub (call stub method)
        }
        
        func resultViewController(for result: ResultX<Question<String>, String>) -> UIViewController {
            return stubbedResults[result] ?? UIViewController() // incase you
        }
    }
}
 

// we dont want public we just want test
extension ResultX: Hashable {
    public static func == (lhs: ResultX<Question, Answer>, rhs: ResultX<Question, Answer>) -> Bool {
        lhs.score == rhs.score
    }
    
    public var hashValue: Int { 1 }
}
