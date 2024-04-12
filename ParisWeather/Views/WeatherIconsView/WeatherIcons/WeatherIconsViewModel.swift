//
//  WeatherIconsViewModel.swift
//  ParisWeather
//
//  Created by Aliaksei Piatrynich on 11/04/2024.
//

import UIKit
import RxSwift
import RxCocoa

final class WeatherIconsViewModel {
    private let disposeBag = DisposeBag()
    private let iconDownloader = WeatherIconDownloader()
    
    private(set) var iconObservables: [Observable<UIImage>] = []

    init(iconNames: Observable<[String]>) {
        iconNames.subscribe(onNext: { [weak self] iconNames in
            guard let `self` = self else {
                return
            }
            self.iconObservables = iconNames.map { iconName in
                self.iconDownloader.download(icon: iconName)
            }.compactMap { $0 }
        })
        .disposed(by: disposeBag)
    }
}
