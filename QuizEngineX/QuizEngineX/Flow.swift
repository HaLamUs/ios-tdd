//
//  Flow.swift
//  QuizEngine
//
//  Created by lamha on 25/10/2022.
//

import Foundation

//class Flow<Question, Answer, R: Router> where R.Answer == Answer, R.Question == Question {
class Flow<Delegate: QuizDelegate> {
    typealias Question = Delegate.Question
    typealias Answer = Delegate.Answer
    
    private let delegate: Delegate
    private let questions: [Question]
    private var newAnswers: [(Question,  Answer)] = []
    
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
            delegate.didCompleteQuiz(withAnswer: newAnswers)
        }
    }
    
    private func delegateQuestionHandling(after index: Int) {
        delegateQuestionHandling(at: questions.index(after: index))
    }
    
    private func answer(for question: Question, at index: Int) -> (Answer) -> Void {
        return {
            [weak self] answer in
            self?.newAnswers.replaceOrInsert((question, answer), at: index)
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
    func start() {
        if let firstQuestion = questions.first {
            delegate.answer(for: firstQuestion, completion: nextCallBack(firstQuestion))
        } else {
            delegate.didCompleteQuiz(withAnswer: newAnswers)
            delegate.handle(result: result())
        }
        
    }
    
    private func nextCallBack(_ question: Question) -> (Answer) -> Void {
        {[weak self] in self?.moveNextQuestion(question, $0)}
    }
    
    private func moveNextQuestion(_ question: Question, _ answer: Answer) {
        newAnswers.append((question, answer))
        if let currentQuestionIndex = questions.firstIndex(of: question) {
            answers[question] = answer
            let nextQuestionIndex = currentQuestionIndex + 1
            if nextQuestionIndex < questions.count {
                let nextQuestion = questions[nextQuestionIndex]
                delegate.answer(for: nextQuestion, completion: nextCallBack(nextQuestion))
            }
            else {
                delegate.didCompleteQuiz(withAnswer: newAnswers)
                delegate.handle( result: result())
            }
        }
    }
    
    private func result() -> ResultX<Question, Answer> {
        ResultX(answers: answers, score: scoring(answers))
    }*/
    



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
