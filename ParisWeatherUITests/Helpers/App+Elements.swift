//
//  App+Elements.swift
//  ParisWeatherUITests
//
//  Created by Aliaksei Piatrynich on 16/04/2024.
//

import Foundation
import XCTest

extension XCUIApplication {
    static let app: XCUIApplication = {
        XCUIApplication()
    }()
    
    subscript (table: String) -> XCUIElement? {
        Self.app.tables[table]
    }
}
