//
//  DailyForecastDetailsCellModel.swift
//  ParisWeather
//
//  Created by Aliaksei Piatrynich on 12/04/2024.
//

import Foundation
import RxSwift
import RxRelay

struct DailyForecastDetailsCellModel {
    let data: BehaviorRelay<FiveDayForecastData?> = BehaviorRelay(value: nil)
    
    init(data: FiveDayForecastData) {
        self.data.accept(data)
    }
}
