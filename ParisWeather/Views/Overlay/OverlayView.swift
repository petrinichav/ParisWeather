//
//  OverlayView.swift
//  ParisWeather
//
//  Created by Aliaksei Piatrynich on 16/04/2024.
//

import UIKit

final class OverlayView: UIView {
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .blue
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        isHidden = false
        
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
        } completion: { _ in
            self.activityIndicator.startAnimating()
        }
    }
    
    func hide() {
        activityIndicator.stopAnimating()
        UIView.animate(withDuration: 0.25) {
            self.alpha = 0
        } completion: { _ in
            self.isHidden = true
        }
    }
}

private extension OverlayView {
    func setupLayout() {
        backgroundColor = .white.withAlphaComponent(0.7)
        
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
