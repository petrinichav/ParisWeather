//
//  WeatherForecastCellModel.swift
//  ParisWeather
//
//  Created by Aliaksei Piatrynich on 11/04/2024.
//

import Foundation
import RxSwift
import UIKit

final class WeatherForecastCellModel {
    private var currentForecast: FiveDayForecastData? {
        dailyForecast.data.first
    }
        
    var currentTemperature: String? {
        currentForecast?.main.temp.temperature
    }
    
    var minTemperature: String? {
        dailyForecast.data.compactMap { $0.main.temp_min }.min()?.temperature
    }
    
    var maxTemperature: String? {
        dailyForecast.data.compactMap { $0.main.temp_max }.max()?.temperature
    }
    
    var feelsLiketemperature: String? {
        currentForecast?.main.feels_like.temperature
    }
    
    var wind: String? {
        currentForecast?.wind.speed.speed
    }
    
    var icons: Observable<[String]> {
        let icons = currentForecast?.weather.map { $0.icon }
        guard let icons = icons  else {
            return Observable.empty()
        }
        return Observable.just(icons)
    }
    
    var date: String {
        dailyForecast.day
    }
    
    let dailyForecast: DailyForecast
    
    init(dailyForecast: DailyForecast) {
        self.dailyForecast = dailyForecast
    }
}
