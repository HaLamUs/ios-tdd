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
    
    func render(title: String) {
        titleLabel.text = title
    }
    
}

class HowToTestFirst: XCTestCase {
    
    func testViewControllerRendersTile() {
        let sut = TitleViewController()
        sut.render(title: "a title")
        XCTAssertEqual(sut.titleLabel.text, "a title")
        
    }
}
