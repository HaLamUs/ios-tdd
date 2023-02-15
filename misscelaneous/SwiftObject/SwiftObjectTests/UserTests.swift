//
//  UserTests.swift
//  SwiftObjectTests
//
//  Created by lamha on 15/02/2023.
//

import XCTest
@testable import SwiftObject

class UserTests: XCTestCase {

    
    
    func testFullNameIsTheCombinationOfFirstAndLastName() {
        let sut = makeUser(firstName: "Lam", lastName: "Ha")
        XCTAssertEqual(sut.fullName(), "Lam Ha")
    }
    
    func testCanUpdateTheFirstName() {
        let sut = makeUser(firstName: "Lam", lastName: "Ha")
        sut.setFirstName("Quang")
        XCTAssertEqual(sut.fullName(), "Quang Ha")
    }
    
    func testPremiumUseAppendAStarToTheFullName() {
        let sut = makePremiumUser(firstName: "Lam", lastName: "Ha")
        XCTAssertEqual(sut.fullName(), "Lam Ha @")
    }
    
    func testCanUpdateFirstNameOfAPremiumUser() {
        let sut = makePremiumUser(firstName: "Lam", lastName: "Ha")
//        sut.setFirstName("Quang")
        sut.0("Quang")
        XCTAssertEqual(sut.fullName(), "Quang Ha @")
    }
    
    // MARK: Helpers
    
    func makeUser(firstName: String, lastName: String) -> (setFirstName: (String) -> Void, fullName: () -> String) {
        makeUserObject(firstName: firstName, lastName: lastName)
    }
    
    func makePremiumUser(firstName: String, lastName: String) -> (setFirstName: (String) -> Void, fullName: () -> String) {
        makePremiumUserObject(firstName: firstName, lastName: lastName)
    }
}



