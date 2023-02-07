//
//  DelegateSpy.swift
//  QuizEngineXTests
//
//  Created by lamha on 07/02/2023.
//

import Foundation
import QuizEngineX

class DelegateSpy: QuizDelegate {
    var quetionAsked: [String] = []
    var completedQuizzes: [[(String, String)]] = []
    var answerCompletions: [(String) -> (Void)] = []
    
    
    func didCompleteQuiz(withAnswer answers: [(question: String, answer: String)]) {
        completedQuizzes.append(answers)
    }
    
    func answer(for question: String, completion: @escaping (String) -> Void) {
        quetionAsked.append(question)
        self.answerCompletions.append(completion)
    }
}
