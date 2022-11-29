//
//  UITableViewExtension.swift
//  QuizApp
//
//  Created by lamha on 29/10/2022.
//

import UIKit

extension UITableView {
    func register(_ type: UITableViewCell.Type) {
        let className = String(describing: type)
        register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T>(_ type: T.Type) -> T? {
        let className = String(describing: type)
        return self.dequeueReusableCell(withIdentifier: className) as? T
    }
}
