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
        XCTAssertEqual(router.routedQuestionCount, 0)
    }
    
    func test_start_withOneQuestions_routesToQuestions() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1"], router: router)

        sut.start()
        XCTAssertEqual(router.routedQuestionCount, 1)
    }
    
    func test_start_withOneQuestions_routesToCorrectQuestions() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1"], router: router)

        sut.start()
        XCTAssertEqual(router.routedQuestion, "Q1")
    }
    
    //spy aka Fake data
    class RouterSpy: Router {
        var routedQuestionCount: Int = 0
        var routedQuestion: String? = nil
        
        func routeTo(question: String) {
            routedQuestion = question
            routedQuestionCount += 1
        }
    }
    
}
