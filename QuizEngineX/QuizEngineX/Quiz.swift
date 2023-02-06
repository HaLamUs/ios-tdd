//
//  Quiz.swift
//  QuizEngineX
//
//  Created by lamha on 08/12/2022.
//

import Foundation

public final class Quiz {
    private let flow: Any
    
    private init(flow: Any) {
        self.flow = flow
    }
    
    public static func start<Delegate: QuizDelegate>(
            questions: [Delegate.Question],
            delegate: Delegate)
            -> Quiz where Delegate.Answer: Equatable
    {
        let flow = Flow(questions: questions,
                        delegate: delegate)
        flow.start() // need to hold strong ref, if not it gone in the middle wont assign back to router
                    // flow after start weak self to move next question
                    // GameTest - router.answerCallback("A1") --> null not call the callback
                    // Solve: return BUT we wrap it into diff type SO no one know about it
        return Quiz(flow: flow)
    }
}

