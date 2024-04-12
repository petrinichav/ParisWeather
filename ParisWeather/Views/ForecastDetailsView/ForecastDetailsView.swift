//
//  ForecastDetailsView.swift
//  ParisWeather
//
//  Created by Aliaksei Piatrynich on 12/04/2024.
//

import UIKit
import RxSwift

/// View to show info as
/// - Humidity
/// - Pressure
/// - Wind
/// - Precipitation
/// - Visibility
final class ForecastDetailsView: UIView {
    private let bag = DisposeBag()
    
    private let dataStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let feelLikeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .yellow.withAlphaComponent(0.5)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel: UILabel = {
        .label(font: .systemFont(ofSize: 16, weight: .medium))
    }()
    
    // TODO: Move to Factory
    private lazy var iconsView: WeatherIconsView = {
        let icons = self.viewModel.icons
        let viewModel = WeatherIconsViewModel(iconNames: icons)
        return WeatherIconsView(viewModel: viewModel)
    }()
    
    let viewModel: ForecastDetailsViewModel
    
    init(viewModel: ForecastDetailsViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        setupLayout()
        setupBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ForecastDetailsView {
    func setupLayout() {
        backgroundColor = .veepeePurple
        
        setupDataStackView()
        setupTemperatureLabel()
        setupIconsView()
        setupFeelsLikeLabel()
        setupTimeLabel()
    }
    
    func setupDataStackView() {
        addSubview(dataStackView)
        NSLayoutConstraint.activate([
            dataStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            dataStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            dataStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            dataStackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width/2)
        ])
    }
    
    func setupTemperatureLabel() {
        addSubview(temperatureLabel)
        
        NSLayoutConstraint.activate([
            temperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -UIScreen.main.bounds.size.width/4),
        ])
    }
    
    func setupIconsView() {
        iconsView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconsView)
        
        NSLayoutConstraint.activate([
            iconsView.leftAnchor.constraint(lessThanOrEqualTo: temperatureLabel.rightAnchor, constant: 10),
            iconsView.topAnchor.constraint(lessThanOrEqualTo: temperatureLabel.topAnchor, constant: 10),
        ])
    }
    
    func setupFeelsLikeLabel() {
        addSubview(feelLikeLabel)
        
        feelLikeLabel.leftAnchor.constraint(equalTo: temperatureLabel.leftAnchor).isActive = true
        feelLikeLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor).isActive = true
    }
    
    func setupTimeLabel() {
        addSubview(timeLabel)
        
        NSLayoutConstraint.activate([
            timeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }
}

private extension ForecastDetailsView {
    func setupBinding() {
        viewModel.temperature
            .bind(to: temperatureLabel.rx.text)
            .disposed(by: bag)
        
        viewModel.feelsLiketemperature
            .compactMap{ "Feels like \($0)" }
            .bind(to: feelLikeLabel.rx.text)
            .disposed(by: bag)
        
        viewModel.time
            .bind(to: timeLabel.rx.text)
            .disposed(by: bag)
        
        viewModel.items
            .compactMap { items in
                return items.map { item in
                    let itemView = ForecastDetailsItemView(frame: .zero)
                    itemView.titleLabel.text = item.title
                    itemView.descriptionLabel.text = item.description
                    itemView.valueLabel.text = item.value
                    return itemView
                }
            }
            .bind(to: dataStackView.rx.arrangedSubviews)
            .disposed(by: bag)
    }
}
