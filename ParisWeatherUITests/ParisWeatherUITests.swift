//
//  ParisWeatherUITests.swift
//  ParisWeatherUITests
//
//  Created by Aliaksei Piatrynich on 09/04/2024.
//

import XCTest

final class ParisWeatherUITests: XCTestCase {

    override func setUpWithError() throws {

        continueAfterFailure = false
        
        XCUIApplication.app.launch()
    }

    // TODO: Better way is adding of stubs for networking call for UI tests. But it requires an integraton some 3dparty or reusing environment variables and if-else statements.
    func testWeatherForecastScreen() {
        let table = XCUIApplication.app.tables.firstMatch
        XCTAssertTrue(table.exists, "table was not initiated")
        XCTAssertTrue(table.cells.count != 0)
        table.swipeDown()
        
        let temperatureLabel = table.cells.firstMatch.staticTexts.matching(identifier: "temperatureLable")
        XCTAssertTrue(temperatureLabel.element.isHittable)
    }
    
    func testOpenForecastDetailsScreenNavigation() {
        let table = XCUIApplication.app.tables.firstMatch
        
        let cell = table.cells.firstMatch
        XCTAssertTrue(cell.isHittable)
        cell.tap()
        
        let dailyForecastTable = XCUIApplication.app.tables.matching(identifier: "DailyForecast")
        // Add a wait condition for the overlay
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: dailyForecastTable.element, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(dailyForecastTable.element.exists, "No daily forecast")
        XCTAssertTrue(dailyForecastTable.cells.count != 0)
    }
}
