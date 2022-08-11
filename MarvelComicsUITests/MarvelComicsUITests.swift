//
//  MarvelComicsUITests.swift
//  MarvelComicsUITests
//
//  Created by Roshan Lamichhane on 8/9/22.
//

import XCTest

class MarvelComicsUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCharactersTableView() throws {
        // Test if tableView and cell exist and tappable
        let app = XCUIApplication()
        app.launch()
        let tableView = app.tables.containing(.table, identifier: "charactersTable")
        XCTAssertNotNil(tableView)
        let cell = tableView.cells.containing(.cell, identifier: "cell")
        XCTAssertTrue(cell.count > 0)
        cell.element(boundBy: 0).tap()
        XCTAssertTrue(cell.accessibilityRespondsToUserInteraction)
    }
}
