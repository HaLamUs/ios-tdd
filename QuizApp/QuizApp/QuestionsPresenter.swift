//
//  QuestionsPresenter.swift
//  QuizApp
//
//  Created by lamha on 10/11/2022.
//

import Foundation

struct QuestionsPresenter {
    let questions: [Question<String>]
    let question: Question<String>
    
    var title: String {
        if let index = questions.index(of: question) {
            return "Question #\(index + 1)"
        }
        return ""
    }
}
