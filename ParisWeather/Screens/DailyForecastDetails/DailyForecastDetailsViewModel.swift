//
//  DailyForecastDetailsViewModel.swift
//  ParisWeather
//
//  Created by Aliaksei Piatrynich on 12/04/2024.
//

import Foundation
import RxSwift

struct DailyForecastDetailsViewModel: ViewModel {
    let navigation = PublishSubject<NavigationDestination>()
    
    let dailyForecast: DailyForecast
    
    init(dailyForecast: DailyForecast) {
        self.dailyForecast = dailyForecast
    }
}
