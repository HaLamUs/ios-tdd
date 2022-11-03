//
//  RouterSpy.swift
//  QuizEngineXTests
//
//  Created by lamha on 03/11/2022.
//

import Foundation
import QuizEngineX

//spy aka Fake data
// This Fake should be simple
class RouterSpy: Router {
    var routedQuestions: [String] = []
    var routedResult: Result<String, String>? = nil
    var answerCallback: ((String) -> (Void)) = { _ in }
    
    func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
        routedQuestions.append(question)
        self.answerCallback = answerCallback
    }
    
    func routeTo(result: Result<String, String>) {
        routedResult = result
    }
}
