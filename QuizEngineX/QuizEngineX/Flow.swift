//
//  Flow.swift
//  QuizEngine
//
//  Created by lamha on 25/10/2022.
//

import Foundation

class Flow<Question: Hashable, Answer, R: Router> where R.Answer == Answer, R.Question == Question {
    private let router: R
    private let questions: [Question]
    private var answers: [Question: Answer] = [:]
    private var scoring: ([Question: Answer]) -> Int
    
    init(questions: [Question], router: R, scoring: @escaping ([Question: Answer]) -> Int) {
        self.questions = questions
        self.router = router
        self.scoring = scoring
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: nextCallBack(firstQuestion))
        } else {
            router.routeTo(result: result())
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
            answers[question] = answer
            let nextQuestionIndex = currentQuestionIndex + 1
            if nextQuestionIndex < questions.count {
                let nextQuestion = questions[nextQuestionIndex]
                router.routeTo(question: nextQuestion, answerCallback: nextCallBack(nextQuestion))
            }
            else {
                router.routeTo(result: result())
            }
        }
    }
    
    private func result() -> Result<Question, Answer> {
        Result(answers: answers, score: scoring(answers))
    }
    
}


/*
 Instead using raw [Question]
 We can create our own Type but when you import to other platform
    need implement de/encrypt
 
 enum Answer<T> {
    case correct(T)
    case incorrect(T)
 }
 
 protocol Answer {
    var isCorrect: Bool { get }
 }
 
 struct StringAnswer {
    let answer: String
    let isCorrect: Bool
 }
 
 struct Question {
    let isMultipleAnswer: Bool
 }
 
 */
