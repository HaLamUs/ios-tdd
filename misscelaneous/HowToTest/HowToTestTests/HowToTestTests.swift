//
//  HowToTestTests.swift
//  HowToTestTests
//
//  Created by lamha on 16/02/2023.
//

import XCTest
@testable import HowToTest

final class TitleViewController: UIViewController {
    
    let titleLabel = UILabel()
    
    convenience init(title: String) {
        self.init()
        titleLabel.text = title
    }
    
}

class HowToTestFirst: XCTestCase {
    
    func testViewControllerRendersTile() {
        // struture of a test
        let viewController = TitleViewController(title: "a title")
        
        // given: the scenario - the set up <-- Second
        
        // when: something happen
        viewController.loadViewIfNeeded()
        
        // then: expect - Assert <-- First
        XCTAssertEqual(viewController.titleLabel.text, "a title")
        
    }
}
