//
//  FirebaseAnalyticsLoginTracker.swift
//  CleanArchitectureComposition
//
//  Created by lamha on 07/03/2023.
//

import Foundation

final class FirebaseAnalyticsLoginTracker: LoginUseCaseOutput {
    func loginSucceeded() {
        // send login event to Firebase
    }
    
    func loginFailed() {
        // send error to Firebase
    }
}
