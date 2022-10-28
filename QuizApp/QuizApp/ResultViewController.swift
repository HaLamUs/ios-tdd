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
}

class CorrectAnswerCell: UITableViewCell {
    
}

class WrongAnswerCell: UITableViewCell {
    
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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        anwsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answer = anwsers[indexPath.row]
        return answer.isCorrect ? CorrectAnswerCell() : WrongAnswerCell()
    }
}
