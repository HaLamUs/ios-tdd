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
        XCTAssertEqual(composer?.count(ofType: LoginPresenter.self), 1)
        XCTAssertEqual(composer?.count(ofType: CrashlyticsLoginTracker.self), 1)
        XCTAssertEqual(composer?.count(ofType: FirebaseAnalyticsLoginTracker.self), 1)
    }

}

private extension LoginUseCaseOutputComposer {
    func count<T>(ofType: T.Type) -> Int {
        outputs.filter { $0 is T }.count
    }
}
