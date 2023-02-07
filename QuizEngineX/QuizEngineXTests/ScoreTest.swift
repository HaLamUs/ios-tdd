//
//  ScoreTest.swift
//  QuizEngineXTests
//
//  Created by lamha on 07/02/2023.
//

import Foundation
import XCTest

class ScoreTest: XCTestCase {
    
    func test_noAnswers_scoresZero() {
        XCTAssertEqual(BasicScore.score(for: [], comparingTo: []), 0)
    }
    
    func test_oneWrongAnswer_scoresZero() {
        XCTAssertEqual(BasicScore.score(for: ["wrong"], comparingTo: ["correct"]), 0)
    }
    
    private class BasicScore {
        static func score(for answers: [Any], comparingTo: [Any]) -> Int {
            -1
        }
    }
}
