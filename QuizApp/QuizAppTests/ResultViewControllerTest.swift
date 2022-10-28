//
//  ResultViewControllerTest.swift
//  QuizAppTests
//
//  Created by lamha on 28/10/2022.
//

import Foundation
import XCTest
@testable import QuizApp

class ResultViewControllerTest: XCTestCase {
    
    func test_viewDidLoad_renderSummary() {
        
        let sut = makeSUT(summary: "a summary")
        XCTAssertEqual(sut.headerLabel.text, "a summary")
    }
    func test_viewDidLoad_renderAnswers() {
        XCTAssertEqual(makeSUT(anwers: [makeDummyAnswer()]).tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(makeSUT(anwers: []).tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_viewDidLoad_withCorrectAnswer_renderCorrectAnswerCell() {
        let sut = makeSUT(anwers: [PresentableAnswer(isCorrect: true)])
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        XCTAssertNotNil(cell)
    }
    
    func test_viewDidLoad_withWrongAnswer_renderWrongAnswerCell() {
        let sut = makeSUT(anwers: [PresentableAnswer(isCorrect: false)])

        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
        XCTAssertNotNil(cell)
    }
    
    // MARK: Helper
    
    func makeSUT(summary: String = "", anwers: [PresentableAnswer] = []) -> ResultViewController {
        let sut = ResultViewController(summary: summary, anwers: anwers)
        _ = sut.view
        return sut
    }
    
    
    func makeDummyAnswer() -> PresentableAnswer {
        PresentableAnswer(isCorrect: true)
    }
    
    
}
