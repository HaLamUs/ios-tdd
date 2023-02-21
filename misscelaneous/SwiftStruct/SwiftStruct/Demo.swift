//
//  Demo.swift
//  SwiftStruct
//
//  Created by lamha on 20/02/2023.
//

import Foundation

struct User {
    let username: String
    let password: String
}

final class AuthenticateUserUseCase {
    let user: User
    let authenticator: UserAuthenticator
    
    init(user: User, authenticator: UserAuthenticator) {
        self.user = user
        self.authenticator = authenticator
    }
    
    func authenticate() -> Bool {
        authenticator.authenticate(user: user)
    }
}

protocol UserAuthenticator {
    func authenticate(user: User) -> Bool
}

struct ImmutatableUserAuthenticator: UserAuthenticator {
    func authenticate(user: User) -> Bool {
        true
    }
}

class SideEffectUserAuthenticator: UserAuthenticator {
    func authenticate(user: User) -> Bool {
        // URLSession ...
        // if sucesss
        return true
        
        //else (network error, wrong username/password, no internet connnection..)
        return false
    }
}
