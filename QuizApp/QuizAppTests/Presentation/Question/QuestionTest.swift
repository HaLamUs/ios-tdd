
// We dont need it anymore 
////
////  QuestionTest.swift
////  QuizAppTests
////
////  Created by lamha on 04/11/2022.
////
//
//import Foundation
//import XCTest
//@testable import QuizEngineX
//
//class QuestionTest: XCTestCase {
//
//    func test_hashValue_withSameWrappedValue_isDifferentForSingleAndMultipleAnswer() {
//        let aValue = UUID()
//
//        // vs cái cách mày tự implement hàm hash mà ko có XOR thì đoạn này nó trả về hashValue sai nha
//        XCTAssertNotEqual(Question.singleAnswer(aValue).hashValue, Question.multipleAnswer(aValue).hashValue)
//    }
//
//    func test_hashValue_forSingleAnswer() {
//
//        let aValue = UUID()
//        let anotherValue = UUID()
//
//        XCTAssertEqual(Question.singleAnswer(aValue).hashValue, Question.singleAnswer(aValue).hashValue)
//
//        XCTAssertNotEqual(Question.singleAnswer(anotherValue).hashValue, Question.singleAnswer(aValue).hashValue)
//
//    }
//
//    func test_hashValue_forMultipleAnswer() {
//
//        let aValue = UUID()
//        let anotherValue = UUID()
//
//        XCTAssertEqual(Question.multipleAnswer(aValue).hashValue, Question.multipleAnswer(aValue).hashValue)
//
//        XCTAssertNotEqual(Question.multipleAnswer(anotherValue).hashValue, Question.multipleAnswer(aValue).hashValue)
//
//    }
//
////
//
//}
