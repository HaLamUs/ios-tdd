//
//  User.swift
//  SwiftObject
//
//  Created by lamha on 15/02/2023.
//

import Foundation

class User {
    
    private var firstName: String
    private let lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func set(firstName: String) {
        self.firstName = firstName
    }
    
    func fullName() -> String {
        firstName + " " + lastName
    }
}

class PremiumUser: User {
    
    override func fullName() -> String {
        super.fullName() + " @"
    }
}
