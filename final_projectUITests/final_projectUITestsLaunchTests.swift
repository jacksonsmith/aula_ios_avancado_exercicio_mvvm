//
//  final_projectUITestsLaunchTests.swift
//  final_projectUITests
//
//  Created by Jackson on 16/08/22.
//

import XCTest

class final_projectUITestsLaunchTests: XCTestCase {
    override class func setUp() {
        super.setUp()
    }
    
    override class func tearDown() {
        super.tearDown()
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func test_should_tap_first_movie_and_validateTitle() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.children(matching: .cell).element(boundBy: 0).tap()
        
        sleep(3)
        let spiderManTitle = app.staticTexts["movie_title"]
        
        XCTAssertEqual(spiderManTitle.label, "Título: Spider-Man: Across the Spider-Verse")
    }
}
