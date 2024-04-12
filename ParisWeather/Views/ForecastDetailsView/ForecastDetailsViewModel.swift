//
//  ForecastDetailsViewModel.swift
//  ParisWeather
//
//  Created by Aliaksei Piatrynich on 12/04/2024.
//

import Foundation
import RxSwift
import RxRelay

final class ForecastDetailsViewModel {
    private let forecast = BehaviorRelay<FiveDayForecastData?>(value: nil)
    private var disposable: Disposable?
    
    deinit {
        disposable?.dispose()
        disposable = nil
    }
    
    private var forecastData: FiveDayForecastData? {
        didSet {
            guard let forecastData = self.forecastData else {
                return
            }
            
            forecast.accept(forecastData)
        }
    }
    
    var items: Observable<[Item]> {
        return forecast.map { forecastData in
            guard let forecastData = forecastData else { return [] }
            
            return [
                Item(title: "Humidity", value: "\(forecastData.main.humidity) %"),
                Item(title: "Pressure", value: Double(forecastData.main.pressure).pressure),
                Item(title: "Wind", description: "Gust \(forecastData.wind.gust.speed)", value: forecastData.wind.speed.speed),
                Item(title: "Precipitation", value: "\(Int(forecastData.pop * 100)) %"),
                Item(title: "Visibility", value: Double(forecastData.visibility).visability)
            ]
        }
    }
    
    var icons: Observable<[String]> {
        forecast.asObservable()
            .compactMap { $0?.weather }
            .map { $0.map { $0.icon } }
    }
    
    var temperature: Observable<String> {
        forecast.asObservable().compactMap { $0?.main.temp.temperature }
    }
    
    var feelsLiketemperature: Observable<String> {
        forecast.asObservable().compactMap { $0?.main.feels_like.temperature }
    }
    
    var time: Observable<String> {
        forecast.asObservable()
            .compactMap { $0?.dt }
            .map {
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm"
                formatter.locale = Locale.current
                formatter.timeZone = TimeZone.current
                let date = Date(timeIntervalSince1970: TimeInterval($0))
                return formatter.string(from: date)
        }
    }
    
    func update(forecastData: BehaviorRelay<FiveDayForecastData?>) {
        disposable?.dispose()
        
        disposable = forecastData
            .subscribe(onNext: { [weak self] data in
                self?.forecastData = data
            })
    }
}

extension ForecastDetailsViewModel {
    struct Item {
        let title: String
        let description: String?
        let value: String
        
        init(title: String, description: String? = nil, value: String) {
            self.title = title
            self.description = description
            self.value = value
        }
    }
}
