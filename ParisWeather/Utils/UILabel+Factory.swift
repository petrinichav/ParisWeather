//
//  UILabel+Factory.swift
//  ParisWeather
//
//  Created by Aliaksei Piatrynich on 12/04/2024.
//

import UIKit

extension UILabel {
    static func label(font: UIFont) -> UILabel {
        let label = UILabel(frame: .zero)
        label.font = font
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
