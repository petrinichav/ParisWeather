//
//  WeatherIconsView.swift
//  ParisWeather
//
//  Created by Aliaksei Piatrynich on 11/04/2024.
//

import UIKit
import RxSwift
import RxCocoa

final class WeatherIconsView: UIView {
    private let viewModel: WeatherIconsViewModel
    private let stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    private let disposeBag = DisposeBag()
    
    init(viewModel: WeatherIconsViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        setupStackView()
        setupImages()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStackView() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setupImages() {
        viewModel.iconObservables.forEach { _ in
            let iconView = WeatherIconView()
            iconView.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(iconView)
            iconView.heightAnchor.constraint(equalToConstant: 30).isActive = true
            iconView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        }
        
        let iconViews: [WeatherIconView] = {
            // force cast because we know that stackview contains only WeatherIconView
            stackView.arrangedSubviews as! [WeatherIconView]
        }()
        
        for (index, iconObservable) in viewModel.iconObservables.enumerated() {
            iconObservable
                .observe(on: MainScheduler.instance)
                .bind(to: iconViews[index].rx.image)
                .disposed(by: disposeBag)
        }
    }
}
