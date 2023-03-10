//
//  Game.swift
//  QuizEngineX
//
//  Created by lamha on 03/11/2022.
//

import Foundation

@available(*, deprecated, message: "Use Quiz instead")
public class Game<Question, Answer, R: Router> {
    let quiz: Quiz
    
    init(quiz: Quiz) {
        self.quiz = quiz
    }
}


@available(*, deprecated, message: "Scoring wont be supported in the future")
public struct ResultX<Question: Hashable, Answer> {
    public let answers: [Question: Answer]
    public let score: Int
    
}

@available(*, deprecated, message: "use Quiz.start instead")
public func startGame<Question, Answer: Equatable, R: Router>
                    (questions: [Question],
                     router: R,
                     correctAnswers:[Question: Answer]) -> Game<Question, Answer, R> where R.Question == Question, R.Answer == Answer
{
    let adapter = QuizDelegateToRouterAdaper(router: router, correctAnswers)
    let quiz = Quiz.start(questions: questions, delegate: adapter)
    return Game(quiz: quiz)
}

@available(*, deprecated, message: "Remove along with the deprecated Game types") 
private class QuizDelegateToRouterAdaper<R: Router>: QuizDelegate where R.Answer: Equatable {
    private let router: R
    private let correctAnswers: [R.Question: R.Answer]
    
    init(router: R, _ correctAnswers: [R.Question: R.Answer]) {
        self.router = router
        self.correctAnswers = correctAnswers
    }
    
    func answer(for question: R.Question, completion: @escaping (R.Answer) -> Void) {
        router.routeTo(question: question, answerCallback: completion)
    }
    
    private func scoring(_ answers: [R.Question: R.Answer],
                 correctAnswers: [R.Question: R.Answer]) -> Int {
        return answers.reduce(0) { // var score = 0
            (score, tuple) in
            return score + ( correctAnswers[tuple.key] == tuple.value ? 1 : 0 )
        }
    }
    
    func didCompleteQuiz(withAnswer answers: [(question: R.Question, answer: R.Answer)]) {
        let answersDictionary = answers.reduce([R.Question: R.Answer]()) {
            acc, tuple in
            var acc = acc
            acc[tuple.question] = tuple.answer
            return acc
        }
        let score = scoring(answersDictionary, correctAnswers: correctAnswers)
        let result = ResultX(answers: answersDictionary, score: score)
        router.routeTo(result: result)
    }
    
    
    
}

/*
 It's a contract that change depend on platform
 */
@available(*, deprecated, message: "Use QuizDelegate instead")
public protocol Router {
    associatedtype Answer
    associatedtype Question: Hashable // why because question used as a key in dict
    
    func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void)
    func routeTo(result: ResultX<Question, Answer>)
}
 
