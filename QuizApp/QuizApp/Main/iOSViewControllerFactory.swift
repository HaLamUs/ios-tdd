//
//  iOSViewControllerFactory.swift
//  QuizAppTests
//
//  Created by lamha on 05/11/2022.
//

import UIKit
import QuizEngineX

class iOSViewControllerFactory: ViewControllerFactory {

    typealias Answers = [(question: Question<String>, answers: [String])]
    
    private let questions: [Question<String>]
    private let options: [Question<String>: [String]]
    private let correctAnswers: Answers
    
    init(options: [Question<String>: [String]], correctAnswers: Answers) {
        self.options = options
        self.questions = correctAnswers.map { $0.question }
        self.correctAnswers = correctAnswers
    }
    
    func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
        guard let option = options[question] else {
            fatalError("Could not find options for question \(question)")
        }
        return questionViewController(for: question, option: option, answerCallback: answerCallback)
    }
    
    private func questionViewController(for question: Question<String>, option: [String], answerCallback: @escaping ([String]) -> Void) -> UIViewController {
        switch question {
            case .singleAnswer(let value):
            return questionViewController(for: question, value: value, allowsMultipleSelection: false, option: option, answerCallback: answerCallback)
        case .multipleAnswer(let value):
            return questionViewController(for: question, value: value, allowsMultipleSelection: true, option: option, answerCallback: answerCallback)
        }
    }
    
    private func questionViewController(for question: Question<String>,
                                        value: String,
                                        allowsMultipleSelection: Bool,
                                        option: [String], answerCallback: @escaping ([String]) -> Void) -> QuestionViewController {
        let presenter = QuestionsPresenter(questions: questions, question: question)
        let controller = QuestionViewController(question: value,
                                                options: option, allowsMultipleSelection: allowsMultipleSelection,
                                                selection: answerCallback)
        controller.title = presenter.title
        return controller
    }
    
    func resultViewController(for userAnswers: Answers) -> UIViewController {
        let presenter = ResultsPresenter(
            userAnswers: userAnswers,
            correctAnswers: correctAnswers,
            scorer:  BasicScore.score
        )
    
        let resultVC = ResultViewController(summary: presenter.summary, anwers: presenter.presentableAnswer)
        resultVC.title = presenter.title
        return resultVC
    }
    
    func resultViewController(for result: ResultX<Question<String>, [String]>) -> UIViewController {
        let presenter = ResultsPresenter(
            userAnswers: questions.map {
            question in
            (question, result.answers[question]!)
        },
            correctAnswers: correctAnswers,
            scorer:  { _, _ in result.score }
        )
    
        let resultVC = ResultViewController(summary: presenter.summary, anwers: presenter.presentableAnswer)
        resultVC.title = presenter.title
        return resultVC
    }
    
}
