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
    
    let crashlyticsTracker: CrashlyticsLoginTracker
    let firebaseTracker: FirebaseAnalyticsLoginTracker
    let loginPresenter: LoginPresenter
    
    init(crashlyticsTracker: CrashlyticsLoginTracker,
         firebaseTracker: FirebaseAnalyticsLoginTracker,
         loginPresenter: LoginPresenter) {
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
