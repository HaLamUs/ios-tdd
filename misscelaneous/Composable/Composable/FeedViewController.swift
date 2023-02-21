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
