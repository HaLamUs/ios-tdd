//
//  QuestionsPresenterTest.swift
//  QuizAppTests
//
//  Created by lamha on 10/11/2022.
//

import Foundation
import XCTest
import QuizEngineX
@testable import QuizApp

class QuestionsPresenterTest: XCTestCase {
    
    let question1 = Question.singleAnswer("Q1")
    let question2 = Question.multipleAnswer("Q2")
    
    func test_title_forFirstQuestion_formatTitleForIndex() {
        let sut = QuestionsPresenter(questions: [question1], question: question1)
        XCTAssertEqual(sut.title, "Question #1")
    }
    
    func test_title_forSecondQuestion_formatTitleForIndex() {
        let sut = QuestionsPresenter(questions: [question1, question2], question: question2)
        XCTAssertEqual(sut.title, "Question #2")
    }
    
    func test_title_forNonExistedQuestion_formatTitleForIndex() {
        let sut = QuestionsPresenter(questions: [], question: question1)
        XCTAssertEqual(sut.title, "")
    }
    
}

