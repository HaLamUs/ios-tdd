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
        sut.set(firstName: "Quang")
        XCTAssertEqual(sut.fullName(), "Quang Ha")
    }
    
    func testPremiumUseAppendAStarToTheFullName() {
        let sut = makePremiumUser(firstName: "Lam", lastName: "Ha")
        XCTAssertEqual(sut.fullName(), "Lam Ha @")
    }
    
    func testCanUpdateFirstNameOfAPremiumUser() {
        let sut = makePremiumUser(firstName: "Lam", lastName: "Ha")
        sut.set(firstName: "Quang")
        XCTAssertEqual(sut.fullName(), "Quang Ha @")
    }
    
    // MARK: Helpers
    
    func makeUser(firstName: String, lastName: String) -> User {
        User(firstName: firstName, lastName: lastName)
    }
    
    func makePremiumUser(firstName: String, lastName: String) -> PremiumUser {
        PremiumUser(firstName: firstName, lastName: lastName)
    }
}


