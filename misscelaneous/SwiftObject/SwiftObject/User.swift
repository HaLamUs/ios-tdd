//
//  User.swift
//  SwiftObject
//
//  Created by lamha on 15/02/2023.
//

import Foundation

struct User {
    let setFirstName: (String) -> Void
    let fullName: () -> String
}

func makeUserObject(firstName: String, lastName: String) -> User {
    
    var _firstName = firstName
    
    return User(
        setFirstName: { newFirstName in
            _firstName = newFirstName
        },
        fullName: {
            return _firstName + " " + lastName
        }
    )
}

struct PremiumUser  {
    let setFirstName: (String) -> Void
    let fullName: () -> String
}

func makePremiumUserObject(firstName: String, lastName: String) -> PremiumUser {
    
    let _super = makeUserObject(firstName: firstName, lastName: lastName)
    
    return PremiumUser(
        setFirstName: _super.setFirstName,
        fullName: {
            return _super.fullName() + " @"
        }
    )
}
