//
//  GameTest.swift
//  QuizEngineXTests
//
//  Created by lamha on 03/11/2022.
//

import Foundation
import XCTest
import QuizEngineX // we dont need @testable coz we want to test public interface

@available(*, deprecated)
class DeprecatedGameTest: XCTestCase {
    private let router = RouterSpy()
    private var game: Game<String, String, RouterSpy>!
    
    override func setUp() {
        super.setUp()
        game = startGame(questions: ["Q1", "Q2"], router: router, correctAnswers: ["Q1": "A1", "Q2": "A2"])
    }
    
    func test_startGame_answerZeroOutOfTwoCorrectly_scoresZero() {
        router.answerCallback("Wrong") //given anwser
        router.answerCallback("Wrong") // given anwser
        
        XCTAssertEqual(router.routedResult!.score, 0)
        
    }
    
    func test_startGame_answerOneOutOfTwoCorrectly_scores1() {
        router.answerCallback("A1") //given anwser
        router.answerCallback("Wrong") // given anwser
        
        XCTAssertEqual(router.routedResult!.score, 1)
        
    }
    
    func test_startGame_answerTwoOutOfTwoCorrectly_scores2() {
        router.answerCallback("A1") //given anwser
        router.answerCallback("A2") // given anwser
        
        XCTAssertEqual(router.routedResult!.score, 2)
        
    }
    
    private class RouterSpy: Router {
        var routedResult: ResultX<String, String>? = nil
        var answerCallback: ((String) -> (Void)) = { _ in }
        
        func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
            self.answerCallback = answerCallback
        }
        
        func routeTo(result: ResultX<String, String>) {
            routedResult = result
        }
    }

    
}
