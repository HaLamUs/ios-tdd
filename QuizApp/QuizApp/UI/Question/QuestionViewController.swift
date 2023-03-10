//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by lamha on 27/10/2022.
//

import Foundation
import UIKit

class QuestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerLabel: UILabel!

    // we expose (set) for tesing
    // fix, test iosVCFactory in the same test with questionVCTest
    private(set) var question: String = ""
    private(set) var allowsMultipleSelection: Bool = false
    private(set) var options = [String]()
    private let reuseIndentifier = "Cell"
    
    private var selection: (([String]) -> Void)? = nil
    
    convenience init(question: String,
                     options: [String],
                     allowsMultipleSelection: Bool,
                     selection: @escaping ([String]) -> Void) {
        self.init()
        self.question = question
        self.options = options
        self.allowsMultipleSelection = allowsMultipleSelection
        self.selection = selection
    }
    
    // remove this we need convenience keyword
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelection = allowsMultipleSelection
        headerLabel.text = question
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selection?([options[indexPath.row]])
//        selection?(tableView.indexPathsForSelectedRows!.map { options[$0.row] })
        selection?(selectOption(in: tableView))
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if allowsMultipleSelection {
            selection?(selectOption(in: tableView))
        }
    }
    
    private func selectOption(in tableView: UITableView) ->[String] {
        guard let index = tableView.indexPathsForSelectedRows else {
            return []
        }
        return index.map { options[$0.row] }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueCell(in: tableView)
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
    private func dequeueCell(in tableView: UITableView) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIndentifier) {
            return cell
        } else {
            return UITableViewCell(style: .default, reuseIdentifier: reuseIndentifier)
        }
    }
}
