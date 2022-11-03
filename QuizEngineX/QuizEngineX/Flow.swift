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
    associatedtype Answer
    associatedtype Question: Hashable // why because question used as a key in dict 
    
    func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void)
    func routeTo(result: [Question: Answer])
}

class Flow<Question: Hashable, Answer, R: Router> where R.Answer == Answer, R.Question == Question {
    private let router: R
    private let questions: [Question]
    private var result: [Question: Answer] = [:]
    
    init(questions: [Question], router: R) {
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
    
    private func nextCallBack(_ question: Question) -> (Answer) -> Void {
//        {
//            [weak self] answer in
//            if let strongSelf = self {
//                strongSelf.moveNextQuestion(question, answer)
//            }
//        }
        {[weak self] in self?.moveNextQuestion(question, $0)}
    }
    
    private func moveNextQuestion(_ question: Question, _ answer: Answer) {
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
