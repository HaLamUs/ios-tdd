//
//  iOSViewControllerTest.swift
//  QuizAppTests
//
//  Created by lamha on 05/11/2022.
//

import Foundation
import XCTest
@testable import QuizApp

class iOSViewControllerFactoryTest: XCTestCase {
    
    func test_questionViewController_createViewController() {
        let question = Question.singleAnswer("Q1")
        let options = ["A1", "A2"]
        let sut = iOSViewControllerFactory(options: [question: options])
        let controller = sut.questionViewController(for: Question.singleAnswer("Q1"), answerCallback: {_ in }) as? QuestionViewController
        XCTAssertNotNil(controller)
        XCTAssertEqual(controller?.question, "Q1")
    }
    
    func test_questionViewController_createViewControllerWithOptions() {
        // some point we need data provider which provides option
        let question = Question.singleAnswer("Q1")
        let options = ["A1", "A2"]
        let sut = iOSViewControllerFactory(options: [question: options])
        let controller = sut.questionViewController(for: question, answerCallback: {_ in }) as! QuestionViewController
        
        XCTAssertEqual(controller.options, options)
    }
    
}
