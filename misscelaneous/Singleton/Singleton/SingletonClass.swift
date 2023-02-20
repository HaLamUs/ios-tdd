//
//  SingletonClass.swift
//  Singleton
//
//  Created by lamha on 20/02/2023.
//

import Foundation
import UIKit

// Main module
extension ApiClient {
    func login(completion: (LoggedinUser) -> Void) {}
}

extension ApiClient {
    func loadFeed(completion: ([FeedItem]) -> Void) {}
}

// API Module
class ApiClient {
    static var shared = ApiClient()
    
    func excute(_ URL: URLRequest, completion: (LoggedinUser) -> Void) {}
}


// Login Module

struct LoggedinUser { }

class LoginViewController: UIViewController {
    
    var login: (((LoggedinUser) -> Void) -> Void)?
    
    func didTapLoginButton() {
        login? {
            user in
            // show feed screen
        }
    }
    
}

// Feed Module
// Now feed module INDEpendently

struct FeedItem { }

class FeedService {
    
    let loadFeed: ((([FeedItem]) -> Void) -> Void)
    
    // force initializer
    init(loadFeed: @escaping ((([FeedItem]) -> Void) -> Void)) {
        self.loadFeed = loadFeed
    }
    
    func load() {
        loadFeed {
            loadedItems in
            // show next screen
        }
    }
    
}
