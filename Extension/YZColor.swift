//
//  YZColor.swift
//  YZLibraries
//
//  Created by Vipul Patel on 18/05/20.
//

import UIKit

//MARK: - UIColor Extension(s)
extension UIColor {

    /// It is used to initialize `UIColor` object as per given parameters.
    /// - Parameters:
    ///   - hex: `Int` type value.
    ///   - alpha: 'CGFloat' type value.
    public convenience init(_ hex:Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat((hex & 0x0000FF) >> 0) / 255.0,
                  alpha: alpha)
    }
    
    /// It is used to initialize `UIColor` object from given hexa decimal value and alpha value.
    /// - Parameters:
    ///   - hexaValue: `String` type hexa decimal value.
    ///   - alpha: `CGFloat` type value to add alpha.
    public convenience init(_ hexaValue: String, alpha: CGFloat = 1.0) {
        var cString: String = hexaValue.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#") {cString.remove(at: cString.startIndex)}
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: CGFloat(alpha))
    }
    
    /// It is used to initialize `UIColor` object from given RGBA value.
    /// - Parameters:
    ///   - red: `Int` type value for red color.
    ///   - green: `Int` type value for green color.
    ///   - blue: `Int` type value for blue color.
    ///   - alpha: `CGFloat` type value for add alpha.
    /// - Returns: It will return `UIColor` object.
    public static func initWith(_ red: Int, green: Int, blue: Int, alpha: CGFloat) -> UIColor {
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    /// It is used to add bright color effect on exisiting color.
    /// - Parameter factor: `CGFloat` type value to add bright color factor.
    /// - Returns: It will return `UIColor` object.
    public func brightenedBy(_ factor: CGFloat) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return UIColor(hue: h, saturation: s, brightness: b * factor, alpha: a)
    }
}
