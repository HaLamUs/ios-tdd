//
//  Game.swift
//  QuizEngineX
//
//  Created by lamha on 03/11/2022.
//

import Foundation

@available(*, deprecated)
public class Game<Question, Answer, R: Router> {//where R.Question == Question, R.Answer == Answer {
    // because this private we dont want change the Router type yet
    let flow: Any//Flow<Question, Answer, R>
    
    init(flow: Any) {//Flow<Question, Answer, R>) {
        self.flow = flow
    }
}


@available(*, deprecated)
public struct ResultX<Question: Hashable, Answer> {
    public let answers: [Question: Answer]
    public let score: Int
    
}

@available(*, deprecated)
public func startGame<Question, Answer: Equatable, R: Router>
                    (questions: [Question],
                     router: R,
                     correctAnswers:[Question: Answer]) -> Game<Question, Answer, R> where R.Question == Question, R.Answer == Answer
{
    let flow = Flow(questions: questions,
                    delegate: QuizDelegateToRouterAdaper(router: router, correctAnswers))
    flow.start() // need to hold strong ref, if not it gone in the middle wont assign back to router
                // flow after start weak self to move next question
                // GameTest - router.answerCallback("A1") --> null not call the callback
                // Solve: return BUT we wrap it into diff type SO no one know about it
    return Game(flow: flow)
}

@available(*, deprecated) 
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
@available(*, deprecated)
public protocol Router {
    associatedtype Answer
    associatedtype Question: Hashable // why because question used as a key in dict
    
    func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void)
    func routeTo(result: ResultX<Question, Answer>)
}
 
