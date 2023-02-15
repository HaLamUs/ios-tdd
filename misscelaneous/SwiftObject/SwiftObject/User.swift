//
//  User.swift
//  SwiftObject
//
//  Created by lamha on 15/02/2023.
//

import Foundation

typealias User = (setFirstName: (String) -> Void, fullName: () -> String)

func makeUserObject(firstName: String, lastName: String) -> User {
    
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

typealias PremiumUser = (setFirstName: (String) -> Void, fullName: () -> String)

func makePremiumUserObject(firstName: String, lastName: String) -> PremiumUser {
    
    let _super = makeUserObject(firstName: firstName, lastName: lastName)
    
    return (
        setFirstName: _super.setFirstName,
        fullName: {
            return _super.fullName() + " @"
        }
    )
}
