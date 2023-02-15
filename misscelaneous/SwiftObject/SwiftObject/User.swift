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

func makeUserObject(firstName: String, lastName: String) -> (setFirstName: (String) -> Void, fullName: () -> String) {
    
    var _firstName = firstName
    
    return (
        setFirstName: { newFirstName in
            _firstName = newFirstName
        },
        fullName: {
            return _firstName + " " + lastName
        }
    )
}

func makePremiumUserObject(firstName: String, lastName: String) -> (setFirstName: (String) -> Void, fullName: () -> String) {
    
    let _user = makeUserObject(firstName: firstName, lastName: lastName)
    
    return (
        setFirstName: _user.setFirstName,
        fullName: {
            return _user.fullName() + " @"
        }
    )
}
