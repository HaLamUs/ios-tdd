//
//  ResultHelper.swift
//  QuizAppTests
//
//  Created by lamha on 09/11/2022.
//

import Foundation
@testable import QuizEngineX //@testable will make limit the scope access ResultX

// we dont want public we just want test
extension ResultX: Hashable {
    
    // Define static so when u call just .make is suffice
    // we make static bcoz we dont want to public the initializer of ResultX
    static func make(answers: [Question: Answer] = [:], score: Int = 0) -> ResultX<Question, Answer> {
        return ResultX(answers: answers, score: score)
    }
    
    public static func == (lhs: ResultX<Question, Answer>, rhs: ResultX<Question, Answer>) -> Bool {
        lhs.score == rhs.score
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(1)
    }
}
