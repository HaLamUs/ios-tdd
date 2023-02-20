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

class MockApiClient: ApiClient {
    
}

class LoginViewController: UIViewController {
    
    // inject remeber using var to inject
    var api = ApiClient.instance
    
    func didTapLoginButton() {
        api.login {
            user in
            // show next screen
        }
    }
    
//    // can not test if use directly
//    func didTapLoginButton() {
//        ApiClient.instance.login {
//            user in
//            // show next screen
//        }
//    }
    
}
