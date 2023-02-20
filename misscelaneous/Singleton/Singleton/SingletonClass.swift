//
//  SingletonClass.swift
//  Singleton
//
//  Created by lamha on 20/02/2023.
//

import Foundation
import UIKit

// API Module
class ApiClient {
    static var shared = ApiClient()
    
    func excute(_ URL: URLRequest, completion: (LoggedinUser) -> Void) {}

    
}


// Login Module

struct LoggedinUser { }

extension ApiClient {
    func login(completion: (LoggedinUser) -> Void) {}
}

class LoginViewController: UIViewController {
    
    var api = ApiClient.shared
    
    func didTapLoginButton() {
        api.login {
            user in
            // show feed screen
        }
    }
    
}

// Feed Module

struct FeedItem { }

extension ApiClient {
    func loadFeed(completion: ([FeedItem]) -> Void) {}
}

class FeedViewController: UIViewController {
    
    var api = ApiClient.shared
    
    func didTapLoginButton() {
        api.loadFeed {
            loadedItems in
            // show next screen
        }
    }
    
}
