//
//  SingletonClass.swift
//  Singleton
//
//  Created by lamha on 20/02/2023.
//

import Foundation
import UIKit

struct LoggedinUser { }

struct FeedItem { }

class ApiClient {
    static var shared = ApiClient()
    
    func login(completion: (LoggedinUser) -> Void) {}
    func loadFeed(completion: ([FeedItem]) -> Void) {}
}

class MockApiClient: ApiClient { }

class LoginViewController: UIViewController {
    
    var api = ApiClient.shared
    
    func didTapLoginButton() {
        api.login {
            user in
            // show feed screen
        }
    }
    
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
