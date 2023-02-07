//
//  QuestionViewControllerTest.swift
//  QuizAppTests
//
//  Created by lamha on 27/10/2022.
//

import Foundation
import XCTest
@testable import QuizApp

class QuestionViewControllerTest: XCTestCase {
    func test_viewDidLoad_rendersQuestionHeaderText() {
        let sut = makeSUT(question: "Q1", options: [])
//        _ = sut.view // we dont call viewDidLoad directlt because it is
        XCTAssertEqual(sut.headerLabel.text, "Q1")
    }
    
    func test_viewDidLoad_withNoOptions_rendersZeroOptions() {
        let sut = makeSUT(question: "Q1", options: [])
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_viewDidLoad_withOneOptions_rendersOneOptions() {
        let sut = makeSUT(question: "Q1", options: ["A1"])
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_viewDidLoad_withOneOptions_rendersOneOptionText() {
        let sut = makeSUT(question: "Q1", options: ["A1"])
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath)
        
        XCTAssertEqual(cell?.textLabel?.text, "A1")
    }
    
    func test_viewDidLoad_rendersOptions() {

        XCTAssertEqual(makeSUT(options: ["A1"]).tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(makeSUT(options: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_viewDidLoad_rendersOptionsText() {
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.title(at: 0), "A1")
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.title(at: 1), "A2")
    }
    
//    func test_optionSelected_notifiesDelegate() {
//        var receivedAnwer = ""
//        let sut = makeSUT(options: ["A1"]) {
//            receivedAnwer = $0
//        }
//
////        let index = IndexPath(row: 0, section: 0)
//        sut.tableView.select(at: 0)
////        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: index)
//        XCTAssertEqual(receivedAnwer, "A1")
//
//    }
    
    func test_viewDidLoad_withSingleSelection_configuresTableView() {
        XCTAssertFalse(makeSUT(options: ["A1", "A2"], allowsMultipleSelection: false).tableView.allowsMultipleSelection)
    }
    
    func test_viewDidLoad_withMultipleSelection_configuresTableView() {
        XCTAssertTrue(makeSUT(options: ["A1", "A2"], allowsMultipleSelection: true).tableView.allowsMultipleSelection)
    }
    
    func test_optionSelected_WithTwoOptions_notifiesDelegateWhenSelectionChanges() {
        var receivedAnwer = [String]()
        let sut = makeSUT(options: ["A1", "A2"], allowsMultipleSelection: false) {
            receivedAnwer = $0
        }
    
        sut.tableView.select(at: 0)
        XCTAssertEqual(receivedAnwer, ["A1"])
        
        sut.tableView.select(at: 1)
        XCTAssertEqual(receivedAnwer, ["A2"])
        
    }
    
    func test_optionSelected_WithMultipleSelectionEnable_notifiesDelegateWhenSelection() {
        var receivedAnwer = [String]()
        let sut = makeSUT(options: ["A1", "A2"], allowsMultipleSelection: true) {
            receivedAnwer = $0
        }

        sut.tableView.select(at: 0)
        XCTAssertEqual(receivedAnwer, ["A1"])

        sut.tableView.select(at: 1)
        XCTAssertEqual(receivedAnwer, ["A1","A2"])

    }
    
    func test_optionDeselected_WithMultipleSelectionEnable_notifiesDelegate() {
        var receivedAnwer = [String]()
        let sut = makeSUT(options: ["A1", "A2"], allowsMultipleSelection: true) {
            receivedAnwer = $0
        }

        sut.tableView.select(at: 0)
        XCTAssertEqual(receivedAnwer, ["A1"])

        sut.tableView.deselect(at: 0)
        XCTAssertEqual(receivedAnwer, [])

    }
    
    
    func test_optionDeselected_withSingleSelection_doesNotNotifiesDelegateWithEmptySelection() {
        var callbackCount = 0
        let sut = makeSUT(options: ["A1", "A2"], allowsMultipleSelection: false) {_ in
            callbackCount += 1
        }

        sut.tableView.select(at: 0)
        XCTAssertEqual(callbackCount, 1)

        sut.tableView.deselect(at: 0)
        XCTAssertEqual(callbackCount, 1)

    }
    
    
    // MARK: Helper
    func makeSUT(question: String = "",
                 options: [String] = [],
                 allowsMultipleSelection: Bool = false,
                 selection: @escaping ([String]) -> Void = { _ in })
    -> QuestionViewController {
//        let questionType = Question.singleAnswer("Q1")
//        let factory = iOSViewControllerFactory(for: [], options: [Question.singleAnswer("Q1"): options])
//
//        let sut = factory.questionViewController(for: questionType, answerCallback: selection) as! QuestionViewController
        let sut = QuestionViewController(question: question,
                                         options: options,
                                         allowsMultipleSelection: allowsMultipleSelection,
                                         selection: selection)
        _ = sut.view
//        sut.tableView.allowsMultipleSelection = allowsMultipleSelection
        return sut
    }
    
}

