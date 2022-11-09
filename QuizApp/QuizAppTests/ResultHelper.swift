//
//  ResultHelper.swift
//  QuizAppTests
//
//  Created by lamha on 09/11/2022.
//

import Foundation
import QuizEngineX

// we dont want public we just want test
extension ResultX: Hashable {
    public static func == (lhs: ResultX<Question, Answer>, rhs: ResultX<Question, Answer>) -> Bool {
        lhs.score == rhs.score
    }
    
    public var hashValue: Int { 1 }
}
