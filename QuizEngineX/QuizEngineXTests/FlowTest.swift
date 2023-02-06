//
//  File.swift
//
//
//  Created by lamha on 25/10/2022.
//

import Foundation
import XCTest
@testable import QuizEngineX

class FlowTest: XCTestCase {
    
    private let delegate = DelegateSpy()
    
    func test_start_withNoQuestions_doesNotDelegateQuestionHandling() {
        let sut = makeSUT(questions: [])
        
        sut.start()
        XCTAssertTrue(delegate.quetionAsked.isEmpty)
//        XCTAssertEqual(router.routedQuestionCount, 0)
    }
    
    func test_start_withOneQuestions_delegatesToCorrectQuestionHandling() {
        let sut = makeSUT(questions: ["Q1"])

        sut.start()
        XCTAssertEqual(delegate.quetionAsked, ["Q1"])
    }
    
    func test_start_withOneQuestions_delegatesAnotherCorrectQuestionHandling() {
        let sut = makeSUT(questions: ["Q2"])

        sut.start()
        XCTAssertEqual(delegate.quetionAsked, ["Q2"])
    }
    
    func test_start_withTwoQuestions_delegatesFirstQuestionHandling() {
        let sut = makeSUT(questions: ["Q1", "Q2"])

        sut.start()
        XCTAssertEqual(delegate.quetionAsked, ["Q1"])
    }
    
    func test_startAndAnwerFirstQuestion_withTwoQuestions_doesntCompleteQuiz() {
        let sut = makeSUT(questions: ["Q1", "Q2"])

        sut.start()
        delegate.answerCompletion("A1")
        XCTAssertTrue(delegate.completedQuizzes.isEmpty)
    }
    
    func test_start_withOneQuestion_delegatesToResultHandling() {
        let sut = makeSUT(questions: ["Q1"])

        sut.start()
        XCTAssertNil(delegate.handledResult)
    }
    
    func test_startTwice_withTwoQuestions_delegatesToFirstQuestionHandlingTwice() {
        let sut = makeSUT(questions: ["Q1", "Q2"])

        sut.start()
        sut.start()
        XCTAssertEqual(delegate.quetionAsked, ["Q1", "Q1"])
    }
    
    func test_startAndAwserFirstAndSecondQuestion_delegatesToSecondAndThirdQuestionHandling() {
        let sut = makeSUT(questions: ["Q1", "Q2", "Q3"])
        

        sut.start()
        delegate.answerCompletion("A1")
        delegate.answerCompletion("A2")
        
        XCTAssertEqual(delegate.quetionAsked, ["Q1","Q2", "Q3"])
    }
    
    func test_startAndAnswerFirstQuestion_withOneQuestion_doesNotDelegateToAnotherQuestionHandling() {
        let sut = makeSUT(questions: ["Q1"])

        sut.start()
        delegate.answerCompletion("A1")
        
        XCTAssertEqual(delegate.quetionAsked, ["Q1"])
    }
    
    func test_start_withOneQuestion_doesNotCompleteQuiz () {
        let sut = makeSUT(questions: ["Q1"])
        
        sut.start()
        XCTAssertTrue(delegate.completedQuizzes.isEmpty)
    }
    
    func test_start_withNoQuestions_completeWithEmptyQuiz () {
        let sut = makeSUT(questions: [])
        
        sut.start()
        XCTAssertEqual(delegate.completedQuizzes.count, 1)
        XCTAssertTrue(delegate.completedQuizzes[0].isEmpty)
    }
    
    func test_startAnswerFirstAndSecondQuestions_withTwoQuestions_completesQuiz() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        
        sut.start()
        delegate.answerCompletion("A1")
        delegate.answerCompletion("A2")
        XCTAssertEqual(delegate.completedQuizzes.count, 1)
//        XCTAssertEqual(delegate.completedQuizzes[0], [("Q1", "A1"), ("Q2", "A2")])
        assertEqual(delegate.completedQuizzes[0], [("Q1", "A1"), ("Q2", "A2")])
    }
    
    // MARK: - Helper
    
    // lil factory helper func
    private func makeSUT(questions: [String]) -> Flow<DelegateSpy> {
        Flow(questions: questions, delegate: delegate)
    }
    
    func test_viewDidLoad_withCorrectAnswer_renderCell() {
        
    }
    
    private func assertEqual(_ a1: [(String, String)], _ a2: [(String, String)], file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertTrue(a1.elementsEqual(a2, by: ==), "\(a1) is not equal to \(a2)", file: file, line: line)
    }
    
    private class DelegateSpy: QuizDelegate {
        var quetionAsked: [String] = []
        var handledResult: ResultX<String, String>? = nil
        var completedQuizzes: [[(String, String)]] = []
        var answerCompletion: ((String) -> (Void)) = { _ in } 
        
        
        func didCompleteQuiz(withAnswer answers: [(question: String, answer: String)]) {
            completedQuizzes.append(answers)
        }
        
        func answer(for question: String, completion: @escaping (String) -> Void) {
            quetionAsked.append(question)
            self.answerCompletion = completion
        }
        
        func handle(result: ResultX<String, String>) {
            handledResult = result
        }
        
    }

}
