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
    func routeTo(question: String, answerCallback: @escaping (String) -> Void)
    func routeTo(result: [String: String])
}

class Flow {
    private let router: Router
    private let questions: [String]
    private var result: [String: String] = [:]
    
    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: nextCallBack(firstQuestion))
        } else {
            router.routeTo(result: result)
        }
        
    }
    
    private func nextCallBack(_ question: String) -> (String) -> Void {
//        {
//            [weak self] answer in
//            if let strongSelf = self {
//                strongSelf.moveNextQuestion(question, answer)
//            }
//        }
        {[weak self] in self?.moveNextQuestion(question, $0)}
    }
    
    private func moveNextQuestion(_ question: String, _ answer: String) {
        if let currentQuestionIndex = questions.index(of: question) {
            result[question] = answer
            let nextQuestionIndex = currentQuestionIndex + 1
            if nextQuestionIndex < questions.count {
                let nextQuestion = questions[nextQuestionIndex]
                router.routeTo(question: nextQuestion, answerCallback: nextCallBack(nextQuestion))
            }
            else {
                router.routeTo(result: result)
            }
        }
    }
    
}
