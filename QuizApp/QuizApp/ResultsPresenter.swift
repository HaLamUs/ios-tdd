//
//  ResultsPresenter.swift
//  QuizApp
//
//  Created by lamha on 09/11/2022.
//

import Foundation
import QuizEngineX

struct ResultsPresenter {
    let result: ResultX<Question<String>, [String]>
    let correctAnswers: [Question<String>: [String]]
    
    var summary: String {
        "You got \(result.score)/\(result.answers.count) correct"
    }
    
    var presentableAnswer: [PresentableAnswer] {
        result.answers.map {
            (question, userAnswer) in
            guard let correctAnswer = correctAnswers[question] else {
                fatalError("Couldnt find correct answer for question: \(question)")
            }
            
            return presentableAnswer(question, userAnswer, correctAnswer)
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
