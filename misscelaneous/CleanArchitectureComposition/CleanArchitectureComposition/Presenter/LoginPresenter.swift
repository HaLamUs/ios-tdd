//
//  LoginPresenter.swift
//  CleanArchitectureComposition
//
//  Created by lamha on 07/03/2023.
//

import Foundation

final class LoginPresenter: LoginUseCaseOutput {
    
    func loginSucceeded() {
        print("\n \n \nloginSucceeded from LoginPresenter \n \n \n")
        // create welcome view model and pass it to the view controller
    }
    
    func loginFailed() {
        // create error view model and pass it to the view controller 
    }
    
    
}
