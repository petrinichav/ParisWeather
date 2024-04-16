//
//  Bundle+Helper.swift
//  ParisWeatherTests
//
//  Created by Aliaksei Piatrynich on 16/04/2024.
//

import Foundation

extension Bundle {
    static let testBundle: Bundle? = {
        Bundle(identifier: "com.alexeyPetrinich.ParisWeatherTests")
    }()
}
