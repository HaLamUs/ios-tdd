//
//  QuizTest.swift
//  QuizEngineXTests
//
//  Created by lamha on 07/12/2022.
//

import Foundation
import XCTest
@testable import QuizEngineX // we dont need @testable coz we want to test public interface

final class Quiz {
    private let flow: Any
    
    private init(flow: Any) {
        self.flow = flow
    }
    
    static func start<Question, Answer: Equatable, Delegate: QuizDelegate>
                        (questions: [Question],
                         delegate: Delegate,
                         correctAnswers:[Question: Answer]) -> Quiz where Delegate.Question == Question, Delegate.Answer == Answer
    {
        let flow = Flow(questions: questions,
                        delegate: delegate,
                        scoring:
                            { scoring($0, correctAnswers: correctAnswers) })
        flow.start() // need to hold strong ref, if not it gone in the middle wont assign back to router
                    // flow after start weak self to move next question
                    // GameTest - router.answerCallback("A1") --> null not call the callback
                    // Solve: return BUT we wrap it into diff type SO no one know about it
        return Quiz(flow: flow)
    }
}

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
    
    private class DelegateSpy: Router, QuizDelegate {
        var handleResult: ResultX<String, String>? = nil
        var answerCallback: ((String) -> (Void)) = { _ in }
        
        func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
            handle(question: question, answerCallback: answerCallback)
        }
        
        func routeTo(result: ResultX<String, String>) {
            handle(result: result)
        }
        
        func handle(question: String, answerCallback: @escaping (String) -> Void) {
            self.answerCallback = answerCallback
        }
        
        func handle(result: ResultX<String, String>) {
            handleResult = result
        }
        
    }

    
}
