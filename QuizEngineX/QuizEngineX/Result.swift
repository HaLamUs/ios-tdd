//
//  Result.swift
//  QuizEngineX
//
//  Created by lamha on 03/11/2022.
//

import Foundation

public struct ResultX<Question: Hashable, Answer> {
    public let answers: [Question: Answer]
    public let score: Int
    
    public init(answers: [Question: Answer], score: Int) {
        self.answers = answers
        self.score = score
    }
}
