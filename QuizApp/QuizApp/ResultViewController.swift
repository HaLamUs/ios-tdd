//
//  ResultViewController.swift
//  QuizApp
//
//  Created by lamha on 28/10/2022.
//

import Foundation
import UIKit

class ResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private var summary: String = ""
    private var anwsers = [PresentableAnswer]()
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    convenience init(summary: String, anwers: [PresentableAnswer]) {
        self.init()
        self.summary = summary
        self.anwsers = anwers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = summary
//        tableView.rowHeight = UITableViewAutomationDemension
        tableView.register(CorrectAnswerCell.self)
        tableView.register(WrongAnswerCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        anwsers.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let answer = anwsers[indexPath.row]
        if answer.wrongAnswer == nil {
            return 70
        }
        else {
            return 90
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answer = anwsers[indexPath.row]
        if answer.wrongAnswer == nil {
            return correctAnswerCell(for: answer)
        }
        else {
            return wrongAnswerCell(for: answer)
        }
    }
    
    private func correctAnswerCell(for answer: PresentableAnswer) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(CorrectAnswerCell.self)!
        cell.questionLabel.text = answer.question
        cell.answerLabel.text = answer.answer
        return cell
    }
    
    private func wrongAnswerCell(for answer: PresentableAnswer) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(WrongAnswerCell.self)!
        cell.questionLabel.text = answer.question
        cell.correctAnswerLabel.text = answer.answer
        cell.wrongAnswerLabel.text = answer.wrongAnswer
        return cell
    }
    
}


