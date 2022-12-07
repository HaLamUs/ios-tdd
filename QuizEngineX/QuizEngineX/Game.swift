//
//  Game.swift
//  QuizEngineX
//
//  Created by lamha on 03/11/2022.
//

import Foundation

@available(*, deprecated)
public class Game<Question, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
    let flow: Flow<Question, Answer, R>
    
    init(flow: Flow<Question, Answer, R>) {
        self.flow = flow
    }
}

@available(*, deprecated)
public func startGame<Question, Answer: Equatable, R: Router>
                    (questions: [Question],
                     router: R,
                     correctAnswers:[Question: Answer]) -> Game<Question, Answer, R>
{
    let flow = Flow(questions: questions,
                    router: router,
                    scoring:
                        { scoring($0, correctAnswers: correctAnswers) })
    flow.start() // need to hold strong ref, if not it gone in the middle wont assign back to router
                // flow after start weak self to move next question
                // GameTest - router.answerCallback("A1") --> null not call the callback
                // Solve: return BUT we wrap it into diff type SO no one know about it
    return Game(flow: flow)
}


private func scoring<Question: Hashable, Answer: Equatable>
                (_ answers: [Question: Answer],
                 correctAnswers: [Question: Answer]) -> Int {
    return answers.reduce(0) { // var score = 0
        (score, tuple) in
        return score + ( correctAnswers[tuple.key] == tuple.value ? 1 : 0 )
    }
}
