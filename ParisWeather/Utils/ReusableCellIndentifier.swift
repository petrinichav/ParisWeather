//
//  ReusableCellIndentifier.swift
//  ParisWeather
//
//  Created by Aliaksei Piatrynich on 10/04/2024.
//

import UIKit

protocol ReusableCellIdentifier {
    static var reusableIdentifier: String { get }
}

// MARK: - UITableViewCell
extension UITableViewCell: ReusableCellIdentifier {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}
