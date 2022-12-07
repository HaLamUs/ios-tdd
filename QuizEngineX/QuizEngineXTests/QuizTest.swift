//
//  QuizTest.swift
//  QuizEngineXTests
//
//  Created by lamha on 07/12/2022.
//

import Foundation
import XCTest
import QuizEngineX // we dont need @testable coz we want to test public interface

class QuizTest: XCTestCase {
    private let delegate = DelegateSpy()
    private var quiz: Quiz!
    
    override func setUp() {
        super.setUp()
        quiz = Quiz.start(questions: ["Q1", "Q2"], delegate: delegate, correctAnswers: ["Q1": "A1", "Q2": "A2"])
    }
    
    func test_startQuiz_answerZeroOutOfTwoCorrectly_scoresZero() {
        delegate.answerCallback("Wrong") //given anwser
        delegate.answerCallback("Wrong") // given anwser
        
        XCTAssertEqual(delegate.handleResult!.score, 0)
        
    }
    
    func test_startQuiz_answerOneOutOfTwoCorrectly_scores1() {
        delegate.answerCallback("A1") //given anwser
        delegate.answerCallback("Wrong") // given anwser
        
        XCTAssertEqual(delegate.handleResult!.score, 1)
        
    }
    
    func test_startQuiz_answerTwoOutOfTwoCorrectly_scores2() {
        delegate.answerCallback("A1") //given anwser
        delegate.answerCallback("A2") // given anwser
        
        XCTAssertEqual(delegate.handleResult!.score, 2)
        
    }
    
    private class DelegateSpy: QuizDelegate {
        var handleResult: ResultX<String, String>? = nil
        var answerCallback: ((String) -> (Void)) = { _ in }
        
        func handle(question: String, answerCallback: @escaping (String) -> Void) {
            self.answerCallback = answerCallback
        }
        
        func handle(result: ResultX<String, String>) {
            handleResult = result
        }
        
    }

    
}
