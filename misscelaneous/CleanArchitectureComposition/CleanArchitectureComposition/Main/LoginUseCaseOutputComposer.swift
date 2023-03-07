//
//  LoginUseCaseOutputComposer.swift
//  CleanArchitectureComposition
//
//  Created by lamha on 07/03/2023.
//

import Foundation

final class LoginUseCaseOutputComposer: LoginUseCaseOutput {
    
    var outputs: [LoginUseCaseOutput]
    init(_ outputs: [LoginUseCaseOutput]) {
        self.outputs = outputs
    }
    
    func loginSucceeded() {
        outputs.forEach { $0.loginSucceeded() }
    }
    
    func loginFailed() {
        outputs.forEach { $0.loginFailed() }
    }
}
