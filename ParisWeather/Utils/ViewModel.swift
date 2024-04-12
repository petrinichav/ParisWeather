//
//  ViewModel.swift
//  ParisWeather
//
//  Created by Aliaksei Piatrynich on 12/04/2024.
//

import RxSwift

protocol ViewModel {
    var navigation: PublishSubject<NavigationDestination> { get }
}
