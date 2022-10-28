//
//  ResultViewController.swift
//  QuizApp
//
//  Created by lamha on 28/10/2022.
//

import Foundation
import UIKit


struct PresentableAnswer {
    let isCorrect: Bool
    let question: String
    let answer: String
}

class CorrectAnswerCell: UITableViewCell {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
}

class WrongAnswerCell: UITableViewCell {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
}

class ResultViewController: UIViewController, UITableViewDataSource {
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
        tableView.register(UINib(nibName: "CorrectAnswerCell", bundle: nil), forCellReuseIdentifier: "CorrectAnswerCell")
        tableView.register(UINib(nibName: "WrongAnswerCell", bundle: nil), forCellReuseIdentifier: "WrongAnswerCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        anwsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answer = anwsers[indexPath.row]
        if answer.isCorrect {
            return correctAnswerCell(for: answer)
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WrongAnswerCell") as! WrongAnswerCell
            cell.questionLabel.text = answer.question
            cell.correctAnswerLabel.text = answer.answer
            return cell
        }
    }
    
    private func correctAnswerCell(for answer: PresentableAnswer) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CorrectAnswerCell") as! CorrectAnswerCell
        cell.questionLabel.text = answer.question
        cell.answerLabel.text = answer.answer
        return cell
    }
    
}
