//
//  WeatherForecastCoordinator.swift
//  ParisWeather
//
//  Created by Aliaksei Piatrynich on 09/04/2024.
//

import UIKit
import RxSwift

final class WeatherForecastCoordinator: Coordinator {
    private weak var navigationcontroller: UINavigationController?
    private let bag = DisposeBag()
    
    init(navigationcontroller: UINavigationController? = nil) {
        self.navigationcontroller = navigationcontroller
    }
    
    func push(direction: NavigationDestination) {
        let viewModel = WeatherForecastViewModel(networkingClient: NetworkingClient())
        let viewController = WeatherForecastViewController(model: viewModel)
        navigationcontroller?.setViewControllers([viewController], animated: false)
        
        viewModel.navigation
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] destination in
                switch destination {
                case .dailyForecastDetail:
                    self?.pushDailyForecastDetails(destination)
                default: break
                }
            })
            .disposed(by: bag)
    }
}

private extension WeatherForecastCoordinator {
    func pushDailyForecastDetails(_ destination: NavigationDestination) {
        let coordinator = DailyForecastDetailsCoordinator(navigationcontroller: navigationcontroller)
        coordinator.push(direction: destination)
    }
}
