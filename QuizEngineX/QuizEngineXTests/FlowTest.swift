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
    
    let router = RouterSpy()
    
    func test_start_withNoQuestions_doesNotRouteToQuestions() {
        let sut = makeSUT(questions: [])
        
        sut.start()
        XCTAssertTrue(router.routedQuestions.isEmpty)
//        XCTAssertEqual(router.routedQuestionCount, 0)
    }
    
    func test_start_withOneQuestions_routesToCorrectQuestions() {
        let sut = makeSUT(questions: ["Q1"])

        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestions_routesToCorrectQuestions2() {
        let sut = makeSUT(questions: ["Q2"])

        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestions_routesToFirstQuestion() {
        let sut = makeSUT(questions: ["Q1", "Q2"])

        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startAndAnwerFirstQuestion_withTwoQuestions_doesntRuleToResult() {
        let sut = makeSUT(questions: ["Q1", "Q2"])

        sut.start()
        router.answerCallback("A1")
        XCTAssertNil(router.routedResult)
    }
    
    func test_start_withOneQuestion_routesToResult() {
        let sut = makeSUT(questions: ["Q1"])

        sut.start()
        XCTAssertNil(router.routedResult)
    }
    
    func test_startTwice_withTwoQuestions_routesToFirstQuestionTwice() {
        let sut = makeSUT(questions: ["Q1", "Q2"])

        sut.start()
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    func test_startAndAwserFirstAndSecondQuestion_routesToSecondAndThirdQuestion() {
        let sut = makeSUT(questions: ["Q1", "Q2", "Q3"])
        

        sut.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        
        XCTAssertEqual(router.routedQuestions, ["Q1","Q2", "Q3"])
    }
    
    func test_startAndAnswerFirstQuestion_withOneQuestion_doesNotRouteToAnotherQuestion() {
        let sut = makeSUT(questions: ["Q1"])

        sut.start()
        router.answerCallback("A1")
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withNoQuestions_routeToResult() {
        let sut = makeSUT(questions: [])
        
        sut.start()
        XCTAssertEqual(router.routedResult!, [:])
    }
    
    func test_startAnswerFirstAndSecondQuestions_withTwoQuestions_routesToResult() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        
        sut.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        XCTAssertEqual(router.routedResult!, ["Q1": "A1", "Q2": "A2"])
    }
    
    // MARK: - Helper
    
    // lil factory helper func
    func makeSUT(questions: [String]) -> Flow {
        Flow(questions: questions, router: router)
    }
    
    //spy aka Fake data
    // This Fake should be simple
    class RouterSpy: Router {
        var routedQuestions: [String] = []
        var routedResult: [String: String]? = nil
        var answerCallback: ((String) -> (Void)) = { _ in }
        
        func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
        
        func routeTo(result: [String : String]) {
            routedResult = result
        }
    }
    
}
