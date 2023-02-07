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
    
    func test_startQuiz_answersAllOfQuestions_completesWithAnswers() {
        quiz = Quiz.start(questions: ["Q1", "Q2"], delegate: delegate)
        delegate.answerCompletions[0]("A1") //given anwser
        delegate.answerCompletions[1]("A2") // given anwser
        
        XCTAssertEqual(delegate.completedQuizzes.count, 1)
        assertEqual(delegate.completedQuizzes[0], [("Q1", "A1"), ("Q2", "A2")])
    }
    
    func test_startQuiz_answersAllOfQuestionsTwice_completesWithNewAnswers() {
        quiz = Quiz.start(questions: ["Q1", "Q2"], delegate: delegate)
        delegate.answerCompletions[0]("A1")
        delegate.answerCompletions[1]("A2")

        delegate.answerCompletions[0]("A1-1")
        delegate.answerCompletions[1]("A2-2")

        XCTAssertEqual(delegate.completedQuizzes.count, 2)
        assertEqual(delegate.completedQuizzes[0], [("Q1", "A1"), ("Q2", "A2")])
        assertEqual(delegate.completedQuizzes[1], [("Q1", "A1-1"), ("Q2", "A2-2")])
    }
    
    private func assertEqual(_ a1: [(String, String)], _ a2: [(String, String)], file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertTrue(a1.elementsEqual(a2, by: ==), "\(a1) is not equal to \(a2)", file: file, line: line)
    }
    
    private class DelegateSpy: QuizDelegate {
        var completedQuizzes: [[(String, String)]] = []
        var answerCompletions: [(String) -> (Void)] = []
        
        
        func didCompleteQuiz(withAnswer answers: [(question: String, answer: String)]) {
            completedQuizzes.append(answers)
        }
        
        func answer(for question: String, completion: @escaping (String) -> Void) {
            self.answerCompletions.append(completion)
        }
        
    }

    
}
