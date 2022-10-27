//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by lamha on 27/10/2022.
//

import Foundation
import UIKit

class QuestionViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerLabel: UILabel!
    
    private var question: String = ""
    private var options = [String]()
    
    convenience init(question: String, options: [String]) {
        self.init()
        self.question = question
        self.options = options
    }
    
    // remove this we need convenience keyword
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = question
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
}
