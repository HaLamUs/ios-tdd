//
//  testDateSpanTests.swift
//  testDateSpanTests
//
//  Created by lamha on 15/03/2023.
//

import XCTest
@testable import testDateSpan

class testDateSpanTests: XCTestCase {
    
    func test_today() {
        // this line is the same as the implementation
//        let startOfToday = Calendar.current.startOfDay(for: Date())
        
        let currentDate = Date(timeIntervalSince1970: 1678891465)
        let startOfToday = Date(timeIntervalSince1970: 1678838400)
        let endOfToday = Date(timeIntervalSince1970: 1678924799)
        
        let result = DateSpan.today.span(currentDate)
        XCTAssertEqual(result.startDate, startOfToday)
        XCTAssertEqual(result.endDate, endOfToday)
    }
    
    
    func test_yesterday() {
        let yesterday = Date(timeIntervalSince1970: 1678691347)
        let startOfYesterday = Date(timeIntervalSince1970: 1678665600)
        let endOfYesterday = Date(timeIntervalSince1970: 1678751999)
        
        let result = DateSpan.today.span(yesterday)
        XCTAssertEqual(result.startDate, startOfYesterday)
        XCTAssertEqual(result.endDate, endOfYesterday)
    }

}
