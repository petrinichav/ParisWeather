//
//  NSAttributedString+Helper.swift
//  ParisWeather
//
//  Created by Aliaksei Piatrynich on 12/04/2024.
//

import Foundation
import UIKit

extension NSAttributedString {
    static func attributedString(image: UIImage, text: String, size: CGSize) -> NSAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = image.withTintColor(.white)
        attachment.bounds = CGRect(origin: .zero, size: size)
        let imageString = NSAttributedString(attachment: attachment)
        
        let textString = NSAttributedString(
            string: " \(text)",
            attributes: [
                .font: UIFont.systemFont(ofSize: 16),
                .foregroundColor: UIColor.white
            ]
        )
        
        let finalString = NSMutableAttributedString()
        finalString.append(imageString)
        finalString.append(textString)
        
        return finalString
    }
}
