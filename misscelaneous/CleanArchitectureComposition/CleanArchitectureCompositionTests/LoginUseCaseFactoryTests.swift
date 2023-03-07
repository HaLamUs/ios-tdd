//
//  LoginUseCaseFactoryTests.swift
//  CleanArchitectureCompositionTests
//
//  Created by lamha on 07/03/2023.
//

import XCTest
@testable import CleanArchitectureComposition

class LoginUseCaseFactoryTests: XCTestCase {

    func test_createUseCase_hasComposedOutputs() {
        let sut = LoginUseCaseFactory()
        let useCase = sut.makeUseCase()
        let composer = useCase.output as? LoginUseCaseOutputComposer
        XCTAssertNotNil(composer)
        XCTAssertEqual(composer?.outputs.count, 3)
        XCTAssertEqual(composer?.outputs.filter { $0 is LoginPresenter }.count, 1)
        XCTAssertEqual(composer?.outputs.filter { $0 is CrashlyticsLoginTracker }.count, 1)
        XCTAssertEqual(composer?.outputs.filter { $0 is FirebaseAnalyticsLoginTracker }.count, 1)
    }

}
