//
//  SceneDelegate.swift
//  spyAsyncTest
//
//  Created by lamha on 15/03/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let vc = ViewController.make(service: QueueDecorator(ServiceX()))
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}

final class ServiceX: Service {
    func load(completion: @escaping (String) -> ()) {
        DispatchQueue.global(qos: .background).async {
            sleep(5)
            completion("Done")
        }
    }
}

final class QueueDecorator: Service {
    let decoratee: Service
    
    init(_ decoratee: Service) {
        self.decoratee = decoratee
    }
    
    func load(completion: @escaping (String) -> ()) {
        decoratee.load { text in
            DispatchQueue.main.async {
                completion(text)
            }
        }
    }
    
}
