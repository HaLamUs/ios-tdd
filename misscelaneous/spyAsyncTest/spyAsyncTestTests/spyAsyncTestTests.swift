//
//  spyAsyncTestTests.swift
//  spyAsyncTestTests
//
//  Created by lamha on 15/03/2023.
//

import XCTest
@testable import spyAsyncTest

class spyAsyncTestTests: XCTestCase {
    
    func test_viewDidLoad_rendersStringFromService() {
        let service = ServiceSpy()
        let sut = ViewController.make(service: service)
        
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.label.text, "Loading...")
        
        service.completion?("a string")
        XCTAssertEqual(sut.label.text, "a string")
    }

    // MARK: Helpers
    private class ServiceSpy: Service {
        // this one we instead. In real, it is from VC
        var completion: ((String) -> Void)?
        
        func load(completion: @escaping (String) -> Void) {
            self.completion = completion
        }
    }
}
