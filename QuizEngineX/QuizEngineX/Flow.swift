//
//  Flow.swift
//  QuizEngine
//
//  Created by lamha on 25/10/2022.
//

import Foundation

final class Flow<Delegate: QuizDelegate> {
    typealias Question = Delegate.Question
    typealias Answer = Delegate.Answer
    
    private let delegate: Delegate
    private let questions: [Question]
    private var answers: [(Question,  Answer)] = []
    
    init(questions: [Question], delegate: Delegate) {
        self.questions = questions
        self.delegate = delegate
    }
    
    func start() {
        delegateQuestionHandling(at: questions.startIndex)
    }
    
    private func delegateQuestionHandling(at index: Int) {
        if index < questions.endIndex {
            let question = questions[index]
            delegate.answer(for: question, completion: answer(for: question, at: index))
        } else {
            delegate.didCompleteQuiz(withAnswer: answers)
        }
    }
    
    private func delegateQuestionHandling(after index: Int) {
        delegateQuestionHandling(at: questions.index(after: index))
    }
    
    private func answer(for question: Question, at index: Int) -> (Answer) -> Void {
        return {
            [weak self] answer in
            self?.answers.replaceOrInsert((question, answer), at: index)
            self?.delegateQuestionHandling(after: index)
        }
    }
}

private extension Array {
    mutating func replaceOrInsert(_ element: Element, at index: Index) {
        if index < count {
            remove(at: index)
        }
        insert(element, at: index)
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
