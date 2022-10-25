//
//  Flow.swift
//  QuizEngine
//
//  Created by lamha on 25/10/2022.
//

import Foundation

/*
 It's a contract that change depend on platform
 */
protocol Router {
    func routeTo(question: String)
}

class Flow {
    let router: Router
    let questions: [String]
    
    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        if !questions.isEmpty {
            router.routeTo(question: "")
        }
        
    }
}
