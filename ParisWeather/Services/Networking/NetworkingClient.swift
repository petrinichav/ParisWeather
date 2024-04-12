//
//  NetworkingClient.swift
//  ParisWeather
//
//  Created by Aliaksei Piatrynich on 09/04/2024.
//

import Foundation
import RxSwift
import RxCocoa

enum RequestError: Error {
    case invalidURL
}

enum Domain: String {
    case weather = "https://api.openweathermap.org/"
    case icon = "https://openweathermap.org/"
}

enum Request {
    case fiveFaysForecast(any RequestData)
    case weatherIcon(path: String, icon: String)
    
    var url: String {
        switch self {
        case .fiveFaysForecast(let requestData):
            return Domain.weather.rawValue + requestData.url
            
        case .weatherIcon(let path, let icon):
            return "\(Domain.icon.rawValue)\(path)\(icon)@2x.png"
        }
    }
    
    func send<Response: Decodable>() throws -> Observable<Response> {
        let client = NetworkingClient()
        guard let urlRequest = try RequestFactory().urlRequest(from: self) else {
            throw RequestError.invalidURL
        }
        return client.run(request: urlRequest)
    }
    
    func data() throws -> Observable<Data> {
        let client = NetworkingClient()
        guard let urlRequest = try RequestFactory().urlRequest(from: self) else {
            throw RequestError.invalidURL
        }
        return client.data(request: urlRequest)
    }
}

private extension Request {
    enum Method: String, CaseIterable {
        case GET
        case POST
        case PUT
        case DELETE
    }
    
    var method: Method {
        switch self {
        case .fiveFaysForecast, .weatherIcon:
            return .GET
        }
    }
}

private struct RequestFactory {
    private let encoder = RequestEncoder()
    
    func urlRequest(from request: Request) throws -> URLRequest? {
        switch request {
        case .fiveFaysForecast(let data):
            var urlComponents = URLComponents(string: request.url)
            urlComponents?.queryItems = Mirror(reflecting: data.model).children.compactMap { child in
                guard let label = child.label else { return nil }
                return URLQueryItem(name: label, value: "\(child.value)")
            }
            
            guard let url = urlComponents?.url else {
                throw RequestError.invalidURL
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = request.method.rawValue
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return urlRequest
            
        case .weatherIcon:
            guard let url = URL(string: request.url) else {
                throw RequestError.invalidURL
            }
            var urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30)
            urlRequest.httpMethod = request.method.rawValue
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return urlRequest
        }
    }
}

private struct RequestEncoder {
    private let encoder = JSONEncoder()
    
    func encode(model: Encodable) throws -> Data? {
        try encoder.encode(model)
    }
}

private struct NetworkingClient {
    func run<Response: Decodable>(request: URLRequest) -> Observable<Response> {
        data(request: request)
            .decode(type: Response.self, decoder: JSONDecoder())
    }
    
    func data(request: URLRequest) -> Observable<Data> {
        URLSession.shared.rx.data(request: request)
    }
}
