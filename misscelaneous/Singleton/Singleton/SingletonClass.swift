//
//  SingletonClass.swift
//  Singleton
//
//  Created by lamha on 20/02/2023.
//

import Foundation
import UIKit

struct LoggedinUser {
    
}

class ApiClient {
    static let instance = ApiClient()
    
    private init() {}
    
    func login(completion: (LoggedinUser) -> Void) {}
}


let client = ApiClient.instance

class LoginViewController: UIViewController {
    
    // can not test if use directly
    func didTapLoginButton() {
        ApiClient.instance.login {
            user in
            // show next screen
        }
    }
    
}
