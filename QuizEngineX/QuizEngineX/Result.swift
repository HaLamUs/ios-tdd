//
//  Result.swift
//  QuizEngineX
//
//  Created by lamha on 03/11/2022.
//

import Foundation

public struct Result<Question: Hashable, Answer> {
    public let answers: [Question: Answer]
    public let score: Int
}
