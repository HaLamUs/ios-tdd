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
        XCTAssertEqual(makeSUT(anwers: [makeAnswer()]).tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(makeSUT(anwers: []).tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_viewDidLoad_withCorrectAnswer_renderCorrectAnswerCell() {
        let sut = makeSUT(anwers: [makeAnswer(answer: "A1")])
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        XCTAssertNotNil(cell)
    }
    
    func test_viewDidLoad_withCorrectAnswer_renderQuestionText() {
        let answer = makeAnswer(question: "Q1")
        let sut = makeSUT(anwers: [answer])
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
    }
    
    func test_viewDidLoad_withCorrectAnswer_configuresCell() {
        let answer = makeAnswer(question: "Q1", answer: "A1")
        let sut = makeSUT(anwers: [answer])
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.answerLabel.text, "A1")
    }
    
    func test_viewDidLoad_withWrongAnswer_configuresCell() {
        let answer = makeAnswer(question: "Q1", answer: "A1", wrongAnswer: "wrong")
        let sut = makeSUT(anwers: [answer])
        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.correctAnswerLabel.text, "A1")
        XCTAssertEqual(cell?.wrongAnswerLabel.text, "wrong")
    }
    
    func test_viewDidLoad_withWrongAnswer_renderWrongAnswerCell() {
        let sut = makeSUT(anwers: [makeAnswer(wrongAnswer: "wrong")])

        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
        XCTAssertNotNil(cell)
    }
    
    // MARK: Helper
    
    func makeSUT(summary: String = "", anwers: [PresentableAnswer] = []) -> ResultViewController {
        let sut = ResultViewController(summary: summary, anwers: anwers)
        _ = sut.view
        return sut
    }
    
    func makeAnswer(question: String = "",
                    answer: String = "",
                    wrongAnswer: String? = nil) -> PresentableAnswer {
        PresentableAnswer(question: question, answer: answer, wrongAnswer: wrongAnswer)
    }
}
