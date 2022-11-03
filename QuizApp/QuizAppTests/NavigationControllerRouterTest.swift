//
//  NavigationControllerRouterTest.swift
//  QuizAppTests
//
//  Created by lamha on 03/11/2022.
//

import Foundation
import XCTest
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
        factory.stub(question: "Q1", with: viewController)
        factory.stub(question: "Q2", with: secondViewController)
    
        sut.routeTo(question: "Q1", answerCallback: { _ in })
        sut.routeTo(question: "Q2", answerCallback: { _ in })

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    func test_routeQuestion_presentsQuestionControllerWithRightCallback() {
        var callBackWasFired = false
        sut.routeTo(question: "Q1", answerCallback: { _ in callBackWasFired = true })
        factory.answerCallback["Q1"]!("anything")

        XCTAssertEqual(navigationController.viewControllers.count, 1)
        
        XCTAssertEqual(callBackWasFired, true)
    }
    
    class NonAnimatedNavigationViewController: UINavigationController {
        
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }
    
    //fake
    class ViewControllerFactoryStub: ViewControllerFactory {
        
        private var stubbedViewControllers = [String: UIViewController]()
        var answerCallback = [String: (String) -> Void]()
        
        func stub(question: String, with viewController: UIViewController) {
            stubbedViewControllers[question] = viewController
        }
        
        func questionViewController(for question: String, answerCallback: @escaping (String) -> Void) -> UIViewController {
            self.answerCallback[question] = answerCallback
            return stubbedViewControllers[question] ?? UIViewController() // incase you forgot stub (call stub method)
        }
    }
    
}
