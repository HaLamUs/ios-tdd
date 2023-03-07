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
    let outputs: [LoginUseCaseOutput]
    
    init(outputs: [LoginUseCaseOutput]) {
        self.outputs = outputs
    }
    
    func login(name: String, password: String) {
        // if succeed
        outputs.forEach { $0.loginSucceeded() }
        // else 
        outputs.forEach { $0.loginFailed() }
    }
}
