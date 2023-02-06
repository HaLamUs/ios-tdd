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
    
    func test_startQuiz_answerZeroOutOfTwoCorrectly_scoresZero() {
        quiz = Quiz.start(questions: ["Q1", "Q2"], delegate: delegate)
        delegate.answerCompletion("A1") //given anwser
        delegate.answerCompletion("A2") // given anwser
        
        XCTAssertEqual(delegate.completedQuizzes.count, 1)
        assertEqual(delegate.completedQuizzes[0], [("Q1", "A1"), ("Q2", "A2")])
    }
    
    private func assertEqual(_ a1: [(String, String)], _ a2: [(String, String)], file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertTrue(a1.elementsEqual(a2, by: ==), "\(a1) is not equal to \(a2)", file: file, line: line)
    }
    
    private class DelegateSpy: QuizDelegate {
        var completedQuizzes: [[(String, String)]] = []
        var answerCompletion: ((String) -> (Void)) = { _ in }
        
        
        func didCompleteQuiz(withAnswer answers: [(question: String, answer: String)]) {
            completedQuizzes.append(answers)
        }
        
        func answer(for question: String, completion: @escaping (String) -> Void) {
            self.answerCompletion = completion
        }
        
        func handle(result: ResultX<String, String>) {
}
        
    }

    
}
