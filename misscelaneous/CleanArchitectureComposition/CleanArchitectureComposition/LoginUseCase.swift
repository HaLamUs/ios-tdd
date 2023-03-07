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
    
    let crashlyticsTracker: LoginUseCaseOutput
    let firebaseTracker: LoginUseCaseOutput
    let loginPresenter: LoginUseCaseOutput
    
    init(crashlyticsTracker: LoginUseCaseOutput,
         firebaseTracker: LoginUseCaseOutput,
         loginPresenter: LoginUseCaseOutput) {
        self.crashlyticsTracker = crashlyticsTracker
        self.firebaseTracker = firebaseTracker
        self.loginPresenter = loginPresenter
    }
    
    func login(name: String, password: String) {
        crashlyticsTracker.loginSucceeded()
        firebaseTracker.loginSucceeded()
        loginPresenter.loginSucceeded()
    }
}
