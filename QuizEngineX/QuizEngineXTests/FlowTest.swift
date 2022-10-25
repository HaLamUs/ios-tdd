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
    
    func test_start_withNoQuestions_doesNotRouteToQuestions() {
        let router = RouterSpy()
        let sut = Flow(questions: [], router: router)
        
        sut.start()
        XCTAssertTrue(router.routedQuestions.isEmpty)
//        XCTAssertEqual(router.routedQuestionCount, 0)
    }
    
    func test_start_withOneQuestions_routesToCorrectQuestions() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1"], router: router)

        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestions_routesToCorrectQuestions2() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q2"], router: router)

        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestions_routesToFirstQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1", "Q2"], router: router)

        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startTwice_withTwoQuestions_routesToFirstQuestionTwice() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1", "Q2"], router: router)

        sut.start()
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    func test_start_withTwoQuestionsAndAnswerFirstQuestion_routesToSecondQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1", "Q2"], router: router)
        

        sut.start()
        router.answerCallback("A1")
        
        XCTAssertEqual(router.routedQuestions, ["Q1","Q2"])
    }
    
    //spy aka Fake data
    // This Fake should be simple
    class RouterSpy: Router {
        var routedQuestions: [String] = []
        var answerCallback: ((String) -> (Void)) = { _ in }
        
        func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
    }
    
}
