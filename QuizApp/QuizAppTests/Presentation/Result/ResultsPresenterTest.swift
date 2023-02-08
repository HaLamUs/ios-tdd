//
//  ResultsPresenterTest.swift
//  QuizAppTests
//
//  Created by lamha on 09/11/2022.
//

import Foundation
import XCTest
@testable import QuizEngineX
@testable import QuizApp

class ResultsPresenterTest: XCTestCase {
    
    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q2")
    
    func test_summaryWithTwoQuestionsAndScoreOne_returnSummary() {
        let userAnswers = [(singleAnswerQuestion, ["A1"]), (multipleAnswerQuestion, ["A2", "A3"])]
        let correctAnswers = [(singleAnswerQuestion, ["A1"]), (multipleAnswerQuestion, ["A2"])]
        let sut = makeSUT(userAnswers: userAnswers, correctAnswers: correctAnswers, score: 1)
        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }
    
    func test_title_returnFormattedTitle() {
//        let sut = ResultsPresenter(result: .make(), questions: [], correctAnswers: [:])
//        let sut = ResultsPresenter(userAnswers: [], correctAnswers: [], scorer: {_, _ in 0})
        XCTAssertEqual(makeSUT().title, "Result")
    }
    
    func test_presentableAnswers_withoutQuestions_isEmpty() {
        let sut = makeSUT(userAnswers: [], correctAnswers: [])
        XCTAssertTrue(sut.presentableAnswer.isEmpty)
    }
    
    func test_presentableAnswers_withWrongSingleAnswer_mapsAnswer() {
        let userAnswers = [(singleAnswerQuestion, ["A1"])]
        let correctAnswers = [(singleAnswerQuestion, ["A2"])]
//        let sut = ResultsPresenter(result: result, questions: [singleAnswerQuestion], correctAnswers: correctAnswers)
        let sut = makeSUT(userAnswers: userAnswers, correctAnswers: correctAnswers)
        XCTAssertEqual(sut.presentableAnswer.count, 1)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A2")
        XCTAssertEqual(sut.presentableAnswer.first!.wrongAnswer, "A1")
    }
    
    func test_presentableAnswers_withWrongMultipleAnswer_mapsAnswer() {
        let answers = [multipleAnswerQuestion: ["A1", "A4"]]
        let correctAnswers = [multipleAnswerQuestion: ["A2", "A3"]]
        
        let result = ResultX.make(answers: answers, score: 0)
        let sut = ResultsPresenter(result: result, questions: [multipleAnswerQuestion], correctAnswers: correctAnswers)
        XCTAssertEqual(sut.presentableAnswer.count, 1)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q2")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A2, A3")
        XCTAssertEqual(sut.presentableAnswer.first!.wrongAnswer, "A1, A4")
    }
    
    func test_presentableAnswers_withRightSingleAnswer_mapsAnswer() {
        let answers = [singleAnswerQuestion: ["A1"]]
        let correctAnswers = [singleAnswerQuestion: ["A1"]]
        
        let result = ResultX.make(answers: answers, score: 0)
        let sut = ResultsPresenter(result: result, questions: [singleAnswerQuestion], correctAnswers: correctAnswers)
        XCTAssertEqual(sut.presentableAnswer.count, 1)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A1")
        XCTAssertNil(sut.presentableAnswer.first!.wrongAnswer)
    }
    
    func test_presentableAnswers_withRightMultipleAnswer_mapsAnswer() {
        let answers = [multipleAnswerQuestion: ["A1", "A4"]]
        let correctAnswers = [multipleAnswerQuestion: ["A1", "A4"]]
        
        let result = ResultX.make(answers: answers, score: 0)
        let sut = ResultsPresenter(result: result, questions: [multipleAnswerQuestion], correctAnswers: correctAnswers)
        XCTAssertEqual(sut.presentableAnswer.count, 1)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q2")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A1, A4")
        XCTAssertNil(sut.presentableAnswer.first!.wrongAnswer)
    }
    
    func test_presentableAnswers_withTwoQuestions_mapsOrderedAnswer() {
        let answers = [multipleAnswerQuestion: ["A2"], singleAnswerQuestion: ["A1", "A4"]]
        let correctAnswers = [multipleAnswerQuestion: ["A2"], singleAnswerQuestion: ["A1", "A4"]]
        let orderedQuestions = [singleAnswerQuestion, multipleAnswerQuestion]
        
        let result = ResultX.make(answers: answers, score: 0)
        let sut = ResultsPresenter(result: result, questions: orderedQuestions, correctAnswers: correctAnswers)
        XCTAssertEqual(sut.presentableAnswer.count, 2)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A1, A4")
        XCTAssertNil(sut.presentableAnswer.first!.wrongAnswer)
        
        XCTAssertEqual(sut.presentableAnswer.last!.question, "Q2")
        XCTAssertEqual(sut.presentableAnswer.last!.answer, "A2")
        XCTAssertNil(sut.presentableAnswer.last!.wrongAnswer)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        userAnswers: ResultsPresenter.Answers = [],
        correctAnswers: ResultsPresenter.Answers = [],
        score: Int = 0
    ) -> ResultsPresenter {
        ResultsPresenter(userAnswers: userAnswers, correctAnswers: correctAnswers, scorer: {_, _ in score })
    }
    
}
