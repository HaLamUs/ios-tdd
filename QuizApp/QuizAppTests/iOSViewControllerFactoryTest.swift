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
    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q2")
    let options = ["A1", "A2"]
    
    func test_questionViewController_singleAnswer_createViewControllerWithTile() {
        let controller = makeQuestionController(question: singleAnswerQuestion)
        let presenter = QuestionsPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: singleAnswerQuestion)
        XCTAssertEqual(controller.title, presenter.title)
    }
    
    func test_questionViewController_singleAnswer_createViewController() {
        let controller = makeQuestionController(question: singleAnswerQuestion)
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
    
    func test_questionViewController_multipleAnswer_createViewControllerWithTile() {
        let controller = makeQuestionController(question: multipleAnswerQuestion)
        let presenter = QuestionsPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: multipleAnswerQuestion)
        XCTAssertEqual(controller.title, presenter.title)
    }
    
    func test_questionViewController_multipleAnswers_createViewController() {
        XCTAssertEqual(makeQuestionController(question: multipleAnswerQuestion).question, "Q2")
    }
    
    func test_questionViewController_multipleAnswers_createViewControllerWithOptions() {
        let controller = makeQuestionController(question: multipleAnswerQuestion)
        XCTAssertEqual(controller.options, options)
    }
    
    func test_questionViewController_multipleAnswers_createViewControllerWithOptionsWithSingleSelection() {
        let controller = makeQuestionController(question: multipleAnswerQuestion)
        _ = controller.view
        XCTAssertTrue(controller.tableView.allowsMultipleSelection)
    }
    
    
    // MARK: Helpers
    
    func makeSUT(options: [Question<String>: [String]]) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(for: [singleAnswerQuestion, multipleAnswerQuestion], options: options)
    }
    
    func makeQuestionController(question: Question<String> = .singleAnswer("")) -> QuestionViewController {
        return makeSUT(options: [question: options]).questionViewController(for: question, answerCallback: {_ in }) as! QuestionViewController
    }
    
}
