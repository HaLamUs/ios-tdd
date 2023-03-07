//
//  CrashlyticsLoginTracker.swift
//  CleanArchitectureComposition
//
//  Created by lamha on 07/03/2023.
//

import Foundation

final class CrashlyticsLoginTracker: LoginUseCaseOutput {
    func loginFailed() {
        // send error to crashlytics
    }
    
    func loginSucceeded() {
        // send login event to crashlytics
    }
}
