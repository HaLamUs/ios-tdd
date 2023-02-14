//
//  SampleTest.swift
//  misscelaneousTests
//
//  Created by lamha on 14/02/2023.
//

import XCTest

class SampleTest: XCTestCase {

    var sample: Sample!
    
    override func setUpWithError() throws {
        print("Set up - Sample test: \(ObjectIdentifier(self))")
        sample = Sample()
    }

    override func tearDownWithError() throws {
        sample = nil
    }
    
    
    func testSample() {
        sample.changeState()
        XCTAssertEqual(sample.state, 1)
    }
    
    func testSample2() {
        sample.changeState()
        XCTAssertEqual(sample.state, 1)
    }

    class Sample {
        var state = 0
        
        func changeState() {
            state += 1
        }
    }

}
