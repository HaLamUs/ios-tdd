//
//  BasicScore.swift
//  QuizApp
//
//  Created by lamha on 07/02/2023.
//

import Foundation

final class BasicScore {
    static func score<T: Equatable>(for answers: [T],
                                    comparingTo correctAnswers: [T]) -> Int {
        return zip (answers, correctAnswers).reduce(0) {
            score, pair in
            return score + (pair.0 == pair.1 ? 1 : 0)
        }
    }
}
