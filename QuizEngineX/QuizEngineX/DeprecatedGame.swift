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
public func startGame<Question, Answer: Equatable, R: Router>
                    (questions: [Question],
                     router: R,
                     correctAnswers:[Question: Answer]) -> Game<Question, Answer, R> where R.Question == Question, R.Answer == Answer
{
    let flow = Flow(questions: questions,
                    delegate: QuizDelegateToRouterAdaper(router: router),
                    scoring:
                        { scoring($0, correctAnswers: correctAnswers) })
    flow.start() // need to hold strong ref, if not it gone in the middle wont assign back to router
                // flow after start weak self to move next question
                // GameTest - router.answerCallback("A1") --> null not call the callback
                // Solve: return BUT we wrap it into diff type SO no one know about it
    return Game(flow: flow)
}

@available(*, deprecated) 
private class QuizDelegateToRouterAdaper<R: Router>: QuizDelegate {
    
    private let router: R
    
    init(router: R) {
        self.router = router
    }
    
    func handle(question: R.Question, answerCallback: @escaping (R.Answer) -> Void) {
        router.routeTo(question: question, answerCallback: answerCallback)
    }
    
    func handle(result: ResultX<R.Question, R.Answer>) {
        router.routeTo(result: result)
    }
    
}


private func scoring<Question: Hashable, Answer: Equatable>
                (_ answers: [Question: Answer],
                 correctAnswers: [Question: Answer]) -> Int {
    return answers.reduce(0) { // var score = 0
        (score, tuple) in
        return score + ( correctAnswers[tuple.key] == tuple.value ? 1 : 0 )
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
 
