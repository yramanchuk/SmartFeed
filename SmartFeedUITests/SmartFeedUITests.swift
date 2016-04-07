//
//  SmartFeedUITests.swift
//  SmartFeedUITests
//
//  Created by Yury Ramanchuk on 3/24/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

import XCTest

class SmartFeedUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app = XCUIApplication()
        app.launchArguments.append("TEST")
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        XCUIDevice.sharedDevice().orientation = .Portrait
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
    }
    
    func testBrowseDismissal() {
        
        let app = XCUIApplication()
        app.navigationBars["Smart Feed"].buttons["add"].tap()
        app.buttons["close"].tap()
        
    }
    
    
    func testAddingFeed() {
        let testFeedTitle = "test title"
        
        let app = XCUIApplication()
        let tablesQuery = app.tables

        XCTAssertEqual(tablesQuery.cells.count, 0)

        app.navigationBars["Smart Feed"].buttons["add"].tap()
        app.buttons["add"].tap()
        XCTAssertEqual(tablesQuery.cells.count, 1)
        
        let cellTitle = app.tables.childrenMatchingType(.Cell).elementBoundByIndex(0).staticTexts[testFeedTitle].label
        XCTAssertEqual(cellTitle, testFeedTitle)

        
        tablesQuery.cells.elementBoundByIndex(0).tap()
        app.navigationBars[testFeedTitle].buttons["Back"].tap()
        
        let editButton = app.navigationBars["Smart Feed"].buttons["edit"]
        editButton.tap()
        tablesQuery.cells.buttons["Delete \(testFeedTitle)"].tap()
        tablesQuery.cells.buttons["Delete"].tap()
        editButton.tap()
        XCTAssertEqual(tablesQuery.cells.count, 0)
    }
    
}
