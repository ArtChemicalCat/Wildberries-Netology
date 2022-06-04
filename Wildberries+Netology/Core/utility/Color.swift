//
//  Color.swift
//  Wildberries+Netology
//
//  Created by Николай Казанин on 04.06.2022.
//

import Foundation
import UIKit

struct Color {
    /// Brand Colors
    static let magenta = UIColor(red: 203, green: 17, blue: 171)
    static let purplish = UIColor(red: 153, green: 0, blue: 153)
    static let darkViolet = UIColor(red: 72, green: 17, blue: 115)
    /// Gray Colors
    static let gray0 = UIColor(0xF6F6F6)
    static let gray1 = UIColor(0xF2F2F2)
    static let gray2 = UIColor(0xE8E8E8)
    static let gray3 = UIColor(0xD5D5D5)
    static let gray4 = UIColor(0xCCCCCC)
    /// Accent Colors
    static let orange = UIColor(0xFF800C)
    static let red = UIColor(0xF44336)
    static let yellow = UIColor(0xFFF508)
    static let green = UIColor(0x4CAF50)
    static let violet = UIColor(0x6C11C9)
}

extension UIColor {
    public convenience init(_ hex: Int) {
        assert(
            0...0xFFFFFF ~= hex,
            "UIColor+Hex: Hex value given to UIColor initialiser should only include RGB values, i.e. the hex value should have six digits." //swiftlint:disable:this line_length
        )
        let red = (hex & 0xFF0000) >> 16
        let green = (hex & 0x00FF00) >> 8
        let blue = (hex & 0x0000FF)
        self.init(red: red, green: green, blue: blue)
    }

    public convenience init(red: Int, green: Int, blue: Int) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha:  1.0
        )
    }
}
