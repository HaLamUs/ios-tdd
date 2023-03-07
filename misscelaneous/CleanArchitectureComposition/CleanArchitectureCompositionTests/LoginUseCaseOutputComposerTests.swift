//
//  LoginUseCaseOutputComposerTests.swift
//  CleanArchitectureCompositionTests
//
//  Created by lamha on 07/03/2023.
//

import XCTest
@testable import CleanArchitectureComposition

class LoginUseCaseOutputComposerTests: XCTestCase {
    
    func test_composingZeroOutputs_doesNotCrash() {
        let sut = LoginUseCaseOutputComposer([])
        sut.loginFailed()
        sut.loginSucceeded()
    }
    
    func test_composingOneOutput_delegatesSucceedMessage() {
        let output1 = LoginUseCaseOutputSpy()
        let sut = LoginUseCaseOutputComposer([output1])
        sut.loginSucceeded()
        XCTAssertEqual(output1.loginSucceedCallCount, 1)
        XCTAssertEqual(output1.loginFailedCallCount, 0)
    }
    
    func test_composingOneOutput_delegatesFailedMessage() {
        let output1 = LoginUseCaseOutputSpy()
        let sut = LoginUseCaseOutputComposer([output1])
        sut.loginFailed()
        XCTAssertEqual(output1.loginSucceedCallCount, 0)
        XCTAssertEqual(output1.loginFailedCallCount, 1)
    }
    
    // MARK: Helper
    class LoginUseCaseOutputSpy: LoginUseCaseOutput {
        var loginSucceedCallCount = 0
        var loginFailedCallCount = 0
        
        func loginSucceeded() {
            loginSucceedCallCount += 1
        }
        
        func loginFailed() {
            loginFailedCallCount += 1
        }
        
        
    }
    
   
}
