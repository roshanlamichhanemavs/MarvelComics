//
//  MarvelComicsTests.swift
//  MarvelComicsTests
//
//  Created by Roshan Lamichhane on 8/9/22.
//

import XCTest
import MarvelComics
@testable import MarvelComics

class MarvelComicsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEnvironmentSetup() throws {
        let environment = Environment()
        let endpoint = Environment.Endpoint.character
        
        let marvelCharactersViewModel = MarvelCharactersViewModel(environment: environment, endPoint: endpoint)
        XCTAssertNotNil(marvelCharactersViewModel, "Successfully created viewmodel")        
    }


}
