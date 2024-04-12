//
//  DailyForecastDetailsCoordinator.swift
//  ParisWeather
//
//  Created by Aliaksei Piatrynich on 12/04/2024.
//

import UIKit

final class DailyForecastDetailsCoordinator: Coordinator {
    private weak var navigationcontroller: UINavigationController?
    
    init(navigationcontroller: UINavigationController? = nil) {
        self.navigationcontroller = navigationcontroller
    }
    
    func push(direction: NavigationDestination) {
        guard case .dailyForecastDetail(let dailyForecast) = direction else {
            return
        }

        let viewModel = DailyForecastDetailsViewModel(dailyForecast: dailyForecast)
        let viewController = DailyForecastDetailsViewController(model: viewModel)
        navigationcontroller?.pushViewController(viewController, animated: true)
    }
}
