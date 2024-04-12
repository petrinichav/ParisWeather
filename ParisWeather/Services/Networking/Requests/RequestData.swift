//
//  RequestData.swift
//  ParisWeather
//
//  Created by Aliaksei Piatrynich on 09/04/2024.
//

import Foundation

protocol RequestData {
    associatedtype Model: Encodable
    var url: String { get }
    var model: Model { get }
}
