//
//  SceneDelegate.swift
//  QuizApp
//
//  Created by lamha on 27/10/2022.
//

import UIKit
import QuizEngineX

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var game: Game<Question<String>, [String], NavigationControllerRouter>?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let question1 = Question.singleAnswer("What is my name?")
        let question2 = Question.multipleAnswer("Where do I live?")
        let questions = [question1, question2]
        
        let option1 = "Lam"
        let option2 = "Ha"
        let option3 = "Biryul"
        let options1 = [option1, option2, option3]
        
        let option4 = "Cam"
        let option5 = "Thai"
        let option6 = "Lao"
        let options2 = [option4, option5, option6]
        
        
        let correctAnswers = [question1: [option3], question2: [option4, option5]]
        
        let factory = iOSViewControllerFactory(for: questions,
                                                  options: [question1: options1, question2: options2],
                                                  correctAnswers: correctAnswers)
        let navigationController = UINavigationController()
        let router = NavigationControllerRouter(navigationController, factory: factory)
        
        guard let windowScence = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScence)
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
        
        game = startGame(questions: questions, router: router, correctAnswers: correctAnswers)
        
        
                
//        guard let windowScence = (scene as? UIWindowScene) else { return }
//        let window = UIWindow(windowScene: windowScence)
//        let viewController = QuestionViewController(question: "This is the question?", options: ["Option 1", "Option 2"]) {
//            print("\n value \($0)")
//        }
//        _ = viewController.view
//        viewController.tableView.allowsMultipleSelection = false
//        window.rootViewController = viewController
//        self.window = window
//        window.makeKeyAndVisible()
        
        
//        guard let windowScence = (scene as? UIWindowScene) else { return }
//        let window = UIWindow(windowScene: windowScence)
//        let viewController = ResultViewController(summary: "You got 1/2 correct answer", anwers: [
//            PresentableAnswer(question: "Q1", answer: "Yes", wrongAnswer: nil),
//            PresentableAnswer(question: "Q2", answer: "Yes", wrongAnswer: "No")
//        ])
//        _ = viewController.view
//        viewController.tableView.allowsMultipleSelection = false
//        window.rootViewController = viewController
//        self.window = window
//        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

