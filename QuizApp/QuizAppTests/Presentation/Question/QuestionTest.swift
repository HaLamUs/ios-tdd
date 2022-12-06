//
//  QuestionTest.swift
//  QuizAppTests
//
//  Created by lamha on 04/11/2022.
//

import Foundation
import XCTest
@testable import QuizEngineX

class QuestionTest: XCTestCase {
    
    func test_hashValue_SingleAnswer_returnTypeHash() {
        
        let type = "A string"
        let sut = Question.singleAnswer(type)
        
        XCTAssertEqual(sut.hashValue, type.hashValue)
        
    }
    
    func test_hashValue_MultipleAnswer_returnTypeHash() {
        
        let type = [""]
        let sut = Question.multipleAnswer(type)
        
        XCTAssertEqual(sut.hashValue, type.hashValue)
        
    }
    
//    func test_equal_isEqual() {
//        XCTAssertEqual(Question.singleAnswer("a string"), Question.singleAnswer("a string"))
//        XCTAssertEqual(Question.multipleAnswer("a string"), Question.multipleAnswer("a string"))
//    }
//    
//    func test_equal_isNotEqual() {
//        XCTAssertNotEqual(Question.singleAnswer("a string"), Question.singleAnswer("another string"))
//        XCTAssertNotEqual(Question.multipleAnswer("a string"), Question.multipleAnswer("another string"))
//        XCTAssertNotEqual(Question.singleAnswer("a string"), Question.multipleAnswer("another string"))
//        XCTAssertNotEqual(Question.multipleAnswer("a string"), Question.singleAnswer("a string"))
//    }
    
}
