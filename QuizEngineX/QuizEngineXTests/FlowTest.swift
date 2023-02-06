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
        XCTAssertTrue(delegate.handleQuestions.isEmpty)
//        XCTAssertEqual(router.routedQuestionCount, 0)
    }
    
    func test_start_withOneQuestions_delegatesToCorrectQuestionHandling() {
        let sut = makeSUT(questions: ["Q1"])

        sut.start()
        XCTAssertEqual(delegate.handleQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestions_delegatesAnotherCorrectQuestionHandling() {
        let sut = makeSUT(questions: ["Q2"])

        sut.start()
        XCTAssertEqual(delegate.handleQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestions_delegatesFirstQuestionHandling() {
        let sut = makeSUT(questions: ["Q1", "Q2"])

        sut.start()
        XCTAssertEqual(delegate.handleQuestions, ["Q1"])
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
        XCTAssertEqual(delegate.handleQuestions, ["Q1", "Q1"])
    }
    
    func test_startAndAwserFirstAndSecondQuestion_delegatesToSecondAndThirdQuestionHandling() {
        let sut = makeSUT(questions: ["Q1", "Q2", "Q3"])
        

        sut.start()
        delegate.answerCompletion("A1")
        delegate.answerCompletion("A2")
        
        XCTAssertEqual(delegate.handleQuestions, ["Q1","Q2", "Q3"])
    }
    
    func test_startAndAnswerFirstQuestion_withOneQuestion_doesNotDelegateToAnotherQuestionHandling() {
        let sut = makeSUT(questions: ["Q1"])

        sut.start()
        delegate.answerCompletion("A1")
        
        XCTAssertEqual(delegate.handleQuestions, ["Q1"])
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
    
    func test_startAnswerFirstAndSecondQuestions_withTwoQuestions_delegatesToResultHandling  () {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        
        sut.start()
        delegate.answerCompletion("A1")
        delegate.answerCompletion("A2")
        XCTAssertEqual(delegate.handledResult!.answers, ["Q1": "A1", "Q2": "A2"])
    }
    
    func test_startAnswerFirstAndSecondQuestions_withTwoQuestions_scores() {
        let sut = makeSUT(questions: ["Q1", "Q2"], scoring: { _ in return 10 })
        
        sut.start()
        delegate.answerCompletion("A1")
        delegate.answerCompletion("A2")
        XCTAssertEqual(delegate.handledResult!.score, 10)
    }
    
    func test_startAnswerFirstAndSecondQuestions_withTwoQuestions_scoresWithRightAnswers() {
        var receivedAnswers = [String:String]()
        let sut = makeSUT(questions: ["Q1", "Q2"], scoring: {
            answers in
            receivedAnswers = answers
            return 20
        })
        
        sut.start()
        delegate.answerCompletion("A1")
        delegate.answerCompletion("A2")
        XCTAssertEqual(receivedAnswers,["Q1": "A1", "Q2": "A2"])
    }
    
    // MARK: - Helper
    
    // lil factory helper func
    private func makeSUT(questions: [String], scoring: @escaping ([String: String]) -> Int = { _ in 0 }) -> Flow<DelegateSpy> {
        Flow(questions: questions, delegate: delegate, scoring: scoring)
    }
    
    func test_viewDidLoad_withCorrectAnswer_renderCell() {
        
    }
    
    private class DelegateSpy: QuizDelegate {
        var handleQuestions: [String] = []
        var handledResult: ResultX<String, String>? = nil
        var completedQuizzes: [[(String, String)]] = []
        var answerCompletion: ((String) -> (Void)) = { _ in } 
        
        
        func didCompleteQuiz(withAnswer answers: [(question: String, answer: String)]) {
            completedQuizzes.append(answers)
        }
        
        func answer(for question: String, completion: @escaping (String) -> Void) {
            handleQuestions.append(question)
            self.answerCompletion = completion
        }
        
        func handle(result: ResultX<String, String>) {
            handledResult = result
        }
        
    }

}
