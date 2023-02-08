//
//  ResultsPresenter.swift
//  QuizApp
//
//  Created by lamha on 09/11/2022.
//

import Foundation
import QuizEngineX

final class ResultsPresenter {
    typealias Answers = [(question: Question<String>, answers: [String])]
    typealias Scorer = ([[String]], [[String]]) -> Int
    
    private let userAnswers: Answers
    private let correctAnswers: Answers
    private let scorer: Scorer
    
    init(result: ResultX<Question<String>, [String]>,
         questions: [Question<String>],
         correctAnswers: Dictionary<Question<String>, [String]>) {
        // conveniently, dict.map return [tuple]
//        self.userAnswers = result.answers.map { $0 } // <-- lam ntn thì ko có order
        self.userAnswers = questions.map {
            question in
            (question, result.answers[question]!)
        }
        self.correctAnswers = questions.map {
            question in
            (question, correctAnswers[question] ?? [])
        }
//        self.scorer = BasicScore.score // <-- using our new Module
        self.scorer = { _, _ in result.score }
    }
    
    var title: String {
        "Result"
    }
    
    var summary: String {
        "You got \(score)/\(userAnswers.count) correct"
    }
    
    private var score: Int {
        scorer(userAnswers.map { $0.answers }, correctAnswers.map { $0.answers })
    }
    
    var presentableAnswer: [PresentableAnswer] {
        return zip(userAnswers, correctAnswers).map{
            userAnswer, correctAnswer in
            return presentableAnswer(userAnswer.question, userAnswer.answers, correctAnswer.answers)
        }
    }
    
    private func presentableAnswer(_ question: Question<String>, _ userAnswer: [String], _ correctAnswer: [String]) -> PresentableAnswer {
        switch question {
        case .singleAnswer(let value), .multipleAnswer(let value):
            return PresentableAnswer(question: value,
                                     answer: fomattedAnswer(correctAnswer),
                                     wrongAnswer: formattedWrongAnswer(userAnswer, correctAnswer))
        }
    }
 
    private func fomattedAnswer(_ answer: [String]) -> String {
        answer.joined(separator: ", ")
    }
    
    private func formattedWrongAnswer(_ userAnswer: [String], _ correctAnswer: [String]) -> String? {
        correctAnswer == userAnswer ? nil : fomattedAnswer(userAnswer)
    }
}
