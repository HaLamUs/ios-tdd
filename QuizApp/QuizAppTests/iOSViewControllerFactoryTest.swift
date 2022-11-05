//
//  iOSViewControllerTest.swift
//  QuizAppTests
//
//  Created by lamha on 05/11/2022.
//

import UIKit
import XCTest
@testable import QuizApp

class iOSViewControllerFactoryTest: XCTestCase {
    
//    func test_questionViewController_withoutOption_createEmptyViewController() {
//        let sut = iOSViewControllerFactory(options: [:])
//        let controller = sut.questionViewController(for: Question.singleAnswer("Q1"), answerCallback: {_ in }) as? QuestionViewController
//        XCTAssertEqual(controller?.question, "")
//        XCTAssertEqual(controller?.options, [])
//    }
    
//    let question = Question.singleAnswer("Q1")
    let options = ["A1", "A2"]
    
    func test_questionViewController_singleAnswer_createViewController() {
        let controller = makeQuestionController(question: .singleAnswer("Q1"))
        XCTAssertNotNil(controller)
        XCTAssertEqual(controller.question, "Q1")
    }
    
    func test_questionViewController_singleAnswer_createViewControllerWithOptions() {
        // some point we need data provider which provides option
        let controller = makeQuestionController()
        XCTAssertEqual(controller.options, options)
    }
    
    func test_questionViewController_singleAnswer_createViewControllerWithOptionsWithSingleSelection() {
        // some point we need data provider which provides option
        
        let controller = makeQuestionController()
        _ = controller.view
        XCTAssertFalse(controller.tableView.allowsMultipleSelection)
    }
    
    func test_questionViewController_multipleAnswers_createViewController() {
        XCTAssertEqual(makeQuestionController(question: .multipleAnswer("Q1")).question, "Q1")
    }
    
    func test_questionViewController_multipleAnswers_createViewControllerWithOptions() {
        let controller = makeQuestionController(question: .multipleAnswer("Q1"))
        XCTAssertEqual(controller.options, options)
    }
    
    func test_questionViewController_multipleAnswers_createViewControllerWithOptionsWithSingleSelection() {
        let controller = makeQuestionController(question: .multipleAnswer("Q1"))
        _ = controller.view
        XCTAssertTrue(controller.tableView.allowsMultipleSelection)
    }
    
    
    // MARK: Helpers
    
    func makeSUT(options: [Question<String>: [String]]) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(options: options)
    }
    
    func makeQuestionController(question: Question<String> = .singleAnswer("")) -> QuestionViewController {
        return makeSUT(options: [question: options]).questionViewController(for: question, answerCallback: {_ in }) as! QuestionViewController
    }
    
}
