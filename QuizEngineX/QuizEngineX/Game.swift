//
//  Game.swift
//  QuizEngineX
//
//  Created by lamha on 03/11/2022.
//

import Foundation

public func startGame<Question: Hashable, Answer, R: Router>(questions: [Question],
                                                             router: R,
                                                             correctAnswers:[Question: Answer]) where R.Question == Question, R.Answer == Answer {
    
}
