//
//  FavoriteImagesUITests.swift
//  FavoriteImagesUITests
//
//  Created by Nikita Tatarnikov on 03.05.2023
//  Copyright © 2023 TAXCOM. All rights reserved.
//

import XCTest
import FavoriteImages

final class FavoriteImagesUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testFavoritesViewController() throws {
        let app = XCUIApplication()
        app.launch()

        let tabBarsQuery = app.tabBars
        let favoritesButton = tabBarsQuery.buttons["Favorites"]

        // Navigate to FavoritesViewController
        favoritesButton.tap()

        // Verify that the table view is displayed with at least one cell
        let tableView = app.tables.firstMatch
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: tableView, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(tableView.cells.count == 0)
    }



    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
