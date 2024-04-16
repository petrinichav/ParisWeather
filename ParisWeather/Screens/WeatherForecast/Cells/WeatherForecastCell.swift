//
//  WeatherForecastCell.swift
//  ParisWeather
//
//  Created by Aliaksei Piatrynich on 11/04/2024.
//

import UIKit

final class WeatherForecastCell: UITableViewCell {
    private let temperatureLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = .white
        label.textAlignment = .center
        label.accessibilityIdentifier = "temperatureLable"
        return label
    }()
    
    private let minTemperatureLabel: UILabel = {
        .label(font: .systemFont(ofSize: 16, weight: .semibold))
    }()
    
    private let maxTemperatureLabel: UILabel = {
        .label(font: .systemFont(ofSize: 16, weight: .semibold))
    }()
    
    private let feelLikeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .yellow.withAlphaComponent(0.5)
        return label
    }()
    
    private let windLabel: UILabel = {
        UILabel(frame: .zero)
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    // TODO: Move to Factory
    private lazy var iconsView: WeatherIconsView? = {
        weatherIconsView()
    }()
    
    var viewModel: WeatherForecastCellModel? {
        didSet {
            setupData()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private - Setup
private extension WeatherForecastCell {
    func setupLayout() {
        contentView.backgroundColor = .veepeePurple
        
        setupTemperatureLabel()
        setupBottomDataPanel()
        setupDateLabel()
        setupFeelsLikeLabel()
    }
    
    func setupTemperatureLabel() {
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(temperatureLabel)
        
        temperatureLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        temperatureLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
    }
    
    func setupBottomDataPanel() {
        let stackView = UIStackView(arrangedSubviews: [
            minTemperatureLabel,
            maxTemperatureLabel,
            windLabel
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 10).isActive = true
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    func setupDateLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)
        dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
    }
    
    func setupIconsViewIfNeeded() {
        iconsView?.removeFromSuperview()
        iconsView = weatherIconsView()
        
        guard let iconsView = self.iconsView else {
            return
        }
        iconsView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(iconsView)
        
        iconsView.leftAnchor.constraint(lessThanOrEqualTo: temperatureLabel.rightAnchor, constant: 10).isActive = true
        iconsView.topAnchor.constraint(equalTo: temperatureLabel.topAnchor).isActive = true
    }
    
    func setupFeelsLikeLabel() {
        feelLikeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(feelLikeLabel)
        
        feelLikeLabel.leftAnchor.constraint(equalTo: temperatureLabel.rightAnchor, constant: 10).isActive = true
        feelLikeLabel.bottomAnchor.constraint(equalTo: temperatureLabel.bottomAnchor).isActive = true
    }
    
    func setupData() {
        temperatureLabel.text = viewModel?.currentTemperature
        dateLabel.text = viewModel?.date
        
        if let feelLikeTemp = viewModel?.feelsLiketemperature {
            feelLikeLabel.text = "Feels like \(feelLikeTemp)"
        }
        
        if let minTemp = viewModel?.minTemperature {
            minTemperatureLabel.text = "↓ \(minTemp)"
        }
        
        if let maxTemp = viewModel?.maxTemperature {
            maxTemperatureLabel.text = "↑ \(maxTemp)"
        }
        
        if let wind = viewModel?.wind {
            windLabel.attributedText = .attributedString(image: .wind, text: wind, size: CGSize(width: 20, height: 20))
        }
                
        setupIconsViewIfNeeded()
    }
}

private extension WeatherForecastCell {
    func weatherIconsView() -> WeatherIconsView? {
        guard let icons = self.viewModel?.icons else {
            return nil
        }
        let viewModel = WeatherIconsViewModel(iconNames: icons)
        return WeatherIconsView(viewModel: viewModel)
    }
}
