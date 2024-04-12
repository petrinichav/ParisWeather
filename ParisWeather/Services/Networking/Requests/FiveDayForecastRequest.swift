//
//  FiveDayForecastRequest.swift
//  ParisWeather
//
//  Created by Aliaksei Piatrynich on 09/04/2024.
//

import Foundation

struct FiveDayForecastRequest: RequestData {
    typealias Model = FiveDayForecastRequestModel
    
    var url: String {
        "data/2.5/forecast"
    }
    
    var model: FiveDayForecastRequestModel {
        FiveDayForecastRequestModel(q: "Paris,FRA", appid: NetworkConstants.apiKey)
    }
}

struct FiveDayForecastRequestModel: Encodable {
    let q: String
    let appid: String
    let units = "metric"
}
