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


class FeedViewController: UIViewController {
    var loader: FeedLoader!
    
    convenience init(loader: FeedLoader) {
        self.init()
        self.loader = loader
    }
    
    func load() {
        loader.loadFeed {
            loadedItems in
            // show next screen
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

struct Reachability {
    static let networkAvaiable: Bool = false
}

// We compose a NEW type (Adapter) from 2 concrete type Remote and Local

class RemoteWithLocalFallbackFeedLoader: FeedLoader {
    var remote: RemoteFeedLoader!
    var local: LocalFeedLoader!
    
    init(remote: RemoteFeedLoader, local: LocalFeedLoader) {
        self.remote = remote
        self.local = local
    }
    
    func loadFeed(completion: @escaping ([String]) -> Void) {
        let load = Reachability.networkAvaiable ? remote.loadFeed : local.loadFeed
        load(completion)
    }
}

let vc = FeedViewController(loader: RemoteFeedLoader())
let vc2 = FeedViewController(loader: LocalFeedLoader())
let vc3 = FeedViewController(loader: RemoteWithLocalFallbackFeedLoader(remote: RemoteFeedLoader(), local: LocalFeedLoader()))
