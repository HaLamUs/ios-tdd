//
//  LoginUseCaseFactory.swift
//  CleanArchitectureComposition
//
//  Created by lamha on 07/03/2023.
//

import Foundation

final class LoginUseCaseFactory {
    
    func makeUseCase() -> LoginUseCase {
        LoginUseCase(output: LoginUseCaseOutputComposer([
            LoginPresenter(),
            CrashlyticsLoginTracker(),
            FirebaseAnalyticsLoginTracker()
        ]))
    }
    
}
