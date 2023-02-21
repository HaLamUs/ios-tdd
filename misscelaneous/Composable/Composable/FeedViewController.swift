//
//  FeedViewController.swift
//  Composable
//
//  Created by lamha on 21/02/2023.
//

import UIKit

protocol FeedLoader {
    func loadFeed(completion: @escaping ([String]) -> Void)
}

struct Reachability {
    static let networkAvaiable: Bool = false
}

class FeedViewController: UIViewController {
    var remote: RemoteFeedLoader!
    var local: LocalFeedLoader!
    
    convenience init(remote: RemoteFeedLoader, local: LocalFeedLoader) {
        self.init()
        self.remote = remote
        self.local = local
    }
    
    func load() {
        if Reachability.networkAvaiable {
            remote.loadFeed { loadedItems in
                
            }
        } else {
            local.loadFeed { loadedItems in }
        }
    }
}

class RemoteFeedLoader: FeedLoader {
    func loadFeed(completion: @escaping ([String]) -> Void) {
        
    }
}

class LocalFeedLoader: FeedLoader {
    func loadFeed(completion: @escaping ([String]) -> Void) {
        
    }
}
