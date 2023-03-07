//
//  LoginUseCaseOutputComposerTests.swift
//  CleanArchitectureCompositionTests
//
//  Created by lamha on 07/03/2023.
//

import XCTest
@testable import CleanArchitectureComposition

class LoginUseCaseOutputComposerTests: XCTestCase {
    
    func test_useGenericFunction() {
        /*
         We no longer using
            - class LoginPresenter
            - class CrashlyticsLoginTracker
            - class FirebaseAnalyticsLoginTracker
         */
        func logEventOnCrashlytics(event: String) {
            print("\(event) logEventOnCrashlytics")
        }
        func logEventOnFirebase(event: String) {
            print("\(event) logEventOnFirebase")
        }
        
        let logEventOnCrashlyticsAndFirebase = compose([logEventOnCrashlytics, logEventOnFirebase])
        
        
        logEventOnCrashlyticsAndFirebase("Hello")
        
    }
    
    func test_closureKnowledge() {
        /*
         1. Init closure
         2. Call closure
         */
        let temp1 = compose2() // init
        temp1("VietNam") // call

        compose2()("Vietnam")
        
        // ================
        
        let temp2 = compose4([{ value in print("\n \n \n Value \(value) \n \n \n ") }])
        temp2("Hello")
        
        let out1 = { (value: String) in print("\n \n \n Func1: Value \(value) \n \n \n ") }
        let out2 = { (value: String) in print("\n \n \n Func2: Value \(value) \n \n \n ") }
        
        let temp2_2 = compose4([ out1, out2 ])
        temp2_2("Hello")
        
        // ================
        
        // just forget this
        let out3 = { (value: LoginPresenter) in value.loginSucceeded() }
        let temp3 = compose([out3])
        temp3(LoginPresenter())


        
        
        
        
        
    }
    
    func test_composingZeroOutputs_doesNotCrash() {
        let sut = LoginUseCaseOutputComposer([])
        sut.loginFailed()
        sut.loginSucceeded()
    }
    
    func test_composingMultipleOutput_delegatesSucceedMessage() {
        let output1 = LoginUseCaseOutputSpy()
        let output2 = LoginUseCaseOutputSpy()
        let sut = LoginUseCaseOutputComposer([output1, output2])
        sut.loginSucceeded()
        XCTAssertEqual(output1.loginSucceedCallCount, 1)
        XCTAssertEqual(output1.loginFailedCallCount, 0)
        
        XCTAssertEqual(output2.loginSucceedCallCount, 1)
        XCTAssertEqual(output2.loginFailedCallCount, 0)
    }
    
    func test_composingMultipleOutput_delegatesFailedMessage() {
        let output1 = LoginUseCaseOutputSpy()
        let output2 = LoginUseCaseOutputSpy()
        let sut = LoginUseCaseOutputComposer([output1, output2])
        sut.loginFailed()
        XCTAssertEqual(output1.loginSucceedCallCount, 0)
        XCTAssertEqual(output1.loginFailedCallCount, 1)
        
        XCTAssertEqual(output2.loginSucceedCallCount, 0)
        XCTAssertEqual(output2.loginFailedCallCount, 1)
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
