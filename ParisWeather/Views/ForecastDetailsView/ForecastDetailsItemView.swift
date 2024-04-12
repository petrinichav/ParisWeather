//
//  ForecastDetailsItemView.swift
//  ParisWeather
//
//  Created by Aliaksei Piatrynich on 12/04/2024.
//

import UIKit

final class ForecastDetailsItemView: UIView {
    let titleLabel: UILabel = {
        .label(font: .systemFont(ofSize: 16, weight: .medium))
    }()
    
    let descriptionLabel: UILabel = {
        .label(font: .systemFont(ofSize: 12, weight: .regular))
    }()
    
    let valueLabel: UILabel = {
        .label(font: .systemFont(ofSize: 16, weight: .bold))
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ForecastDetailsItemView {
    func setupLayout() {
        setupTitleLabel()
        setupDescriptionLabel()
        setupValueLabel()
    }
    
    func setupTitleLabel() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
        ])
    }
    
    func setupDescriptionLabel() {
        addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    func setupValueLabel() {
        addSubview(valueLabel)
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            valueLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
        ])
    }
}
