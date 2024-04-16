//
//  NetworkingClientMock.swift
//  ParisWeatherTests
//
//  Created by Aliaksei Piatrynich on 15/04/2024.
//

import Foundation
import RxSwift
@testable import ParisWeather

struct NetworkingClientMock: NetworkingClientable {
    private let expectedResult: Result<Decodable, Error>
    
    init(result: Result<Decodable, Error>) {
        self.expectedResult = result
    }
    
    func run<Response>(request: URLRequest) -> Observable<Response> where Response : Decodable {
        switch expectedResult {
        case .success(let response):
            guard let response = response as? Response else {
                return Observable.error(ErrorMock.unexpectedResult)
            }
            return Observable.just(response)
            
        case .failure(let error):
            return Observable.error(error)
        }
    }
    
    func data(request: URLRequest) -> Observable<Data> {
        Observable.just(Data())
    }
}

private extension NetworkingClientMock {
    func fetchFiveDaysForecastMock() -> Observable<FiveDayForecastResponse> {
        Observable.empty()
    }
}

enum ErrorMock: String, Error {
    case unexpectedResult
    case invalidJSONPath
}
