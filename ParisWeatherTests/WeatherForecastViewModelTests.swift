//
//  WeatherForecastViewModelTests.swift
//  ParisWeatherTests
//
//  Created by Aliaksei Piatrynich on 09/04/2024.
//

import XCTest
@testable import ParisWeather
import RxSwift

final class WeatherForecastViewModelTests: XCTestCase {
    private let bag = DisposeBag()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetForecastDataSuccess() throws {
        let response = try ResponseMockFactory.fiveDayForecasts()
        let networkingClinet = NetworkingClientMock(result: .success(response))
        
        let expectation = XCTestExpectation(description: "Received 5 days forecast")
        
        let viewModel = WeatherForecastViewModel(networkingClient: networkingClinet)
        viewModel.forecast
            .skip(1)
            .subscribe(onNext: { forecast in
                XCTAssertNotNil(forecast, "Unexpected forecast")
                
                expectation.fulfill()

        }).disposed(by: bag)
        
        viewModel.fetchWeatherForcast()
        
        wait(for: [expectation])
    }
    
    func testGetForecaseDataFailure() throws {
        let networkingClinet = NetworkingClientMock(result: .failure(ErrorMock.unexpectedResult))
        
        let expectation = XCTestExpectation(description: "Received 5 days forecast")
        
        let viewModel = WeatherForecastViewModel(networkingClient: networkingClinet)
        viewModel.forecast
            .skip(1)
            .subscribe(onNext: { forecast in
                XCTAssertNil(forecast, "Unexpected forecast, should be nil")
                expectation.fulfill()

            }, onError: { error in
                let expectedError = error as? ErrorMock
                XCTAssertNotNil(expectedError, "Expecting error")
                XCTAssertTrue(expectedError == .unexpectedResult, "Expecting antoher error")
                expectation.fulfill()
            }).disposed(by: bag)
        
        viewModel.fetchWeatherForcast()
        
        wait(for: [expectation])
    }
    
    func testGetNoForecastData() throws {
        let response = try ResponseMockFactory.emptyFiveDayForecasts()
        let networkingClinet = NetworkingClientMock(result: .success(response))
        
        let expectation = XCTestExpectation(description: "Received 5 days forecast")
        
        let viewModel = WeatherForecastViewModel(networkingClient: networkingClinet)
        viewModel.forecast
            .skip(1)
            .subscribe(onNext: { forecast in
                XCTAssertNotNil(forecast, "Unexpected forecast")
                XCTAssertTrue(forecast?.isEmpty == true, "Unexpected data in response")
                expectation.fulfill()

        }).disposed(by: bag)
        
        viewModel.fetchWeatherForcast()
        
        wait(for: [expectation])
    }
}
