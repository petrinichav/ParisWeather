//
//  Measurement+Helper.swift
//  ParisWeather
//
//  Created by Aliaksei Piatrynich on 12/04/2024.
//

import Foundation

extension Double {
    var temperature: String {
        let measurment = Measurement(value: self.rounded(.toNearestOrEven), unit: UnitTemperature.celsius)
        return measurment.formatted()
    }
    
    var speed: String {
        let measurement = Measurement(value: self.rounded(.toNearestOrEven), unit: UnitSpeed.metersPerSecond)
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        return formatter.string(from: measurement)
    }
    
    var pressure: String {
        let measurement = Measurement(value: self, unit: UnitPressure.hectopascals)
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        return formatter.string(from: measurement)
    }
    
    var visability: String {
        let measurment = Measurement(value: self, unit: UnitLength.meters)
        return measurment.converted(to: .kilometers).formatted()
    }
}
