//
//  UIStackView+Helper.swift
//  ParisWeather
//
//  Created by Aliaksei Piatrynich on 12/04/2024.
//

import UIKit
import RxSwift

extension UIStackView {
  func removeArrangedSubviews() {
    arrangedSubviews.forEach({
      self.removeArrangedSubview($0)
      $0.removeFromSuperview()
    })
  }
  
  func addArrangedSubviews(_ subviews: [UIView]) {
    subviews.forEach({
      addArrangedSubview($0)
    })
  }
}

extension Reactive where Base: UIStackView {
    var arrangedSubviews: Binder<[UIView]> {
        return Binder(self.base) { stackView, views in
            stackView.removeArrangedSubviews()
            stackView.addArrangedSubviews(views)
        }
    }
}
