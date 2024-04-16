//
//  ResponseMockFactory.swift
//  ParisWeatherTests
//
//  Created by Aliaksei Piatrynich on 16/04/2024.
//

import Foundation
@testable import ParisWeather

enum ResponseMockFactory {
    static func fiveDayForecasts() throws -> FiveDayForecastResponse {
        guard let path = Bundle.testBundle?.path(forResource: "weather", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            print("Error loading JSON file")
            throw ErrorMock.invalidJSONPath
        }

        let decoder = JSONDecoder()
        let response = try decoder.decode(FiveDayForecastResponse.self, from: data)
        return response
    }
    
    static func emptyFiveDayForecasts()  throws -> FiveDayForecastResponse {
        guard let path = Bundle.testBundle?.path(forResource: "emptyWeather", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            print("Error loading JSON file")
            throw ErrorMock.invalidJSONPath
        }

        let decoder = JSONDecoder()
        let response = try decoder.decode(FiveDayForecastResponse.self, from: data)
        return response
    }
}
