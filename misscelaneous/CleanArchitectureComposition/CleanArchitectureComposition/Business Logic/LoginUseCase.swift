//
//  LoginUseCase.swift
//  CleanArchitectureComposition
//
//  Created by lamha on 07/03/2023.
//

import Foundation
import UIKit


protocol LoginUseCaseOutput {
    
    func loginSucceeded()
    func loginFailed()
}

// Normal way, using concrete type
class LoginUseCase {
    let output: LoginUseCaseOutput
    
    init(output: LoginUseCaseOutput) {
        self.output = output
    }
    
    func login(name: String, password: String) {
        // if succeed output.loginSucceeded() }
        // else output.loginFailed() }
    }
}
