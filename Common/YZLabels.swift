//
//  YZLabels.swift
//  YZLibraries
//
//  Created by Vipul Patel on 15/05/20.
//

import UIKit

//MARK: - Class YZParentWidthLBL
/// It is used when, you want to design `UILabel` as per multiple device support and apply `widthRatio`.
public class YZParentWidthLBL: UILabel {
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        font = font.withSize(font.pointSize * YZAppConfig.widthRatio)
    }
}

//MARK: - Class YZParentHeightLBL
/// It is used when, you want to design `UILabel` as per multiple device support and apply `heightRatio`.
public class YZParentHeightLBL: UILabel {
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        font = font.withSize(font.pointSize * YZAppConfig.heightRatio)
    }
}

//MARK: - UILabel Extension
extension UILabel {

    /// It is used to check given label is truncated or not. It will return `Bool` type value.
    public var isTruncated: Bool {
        guard let labelText = text else {
            return false
        }
        let labelTextSize = (labelText as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font!],
            context: nil).size
        return labelTextSize.height > bounds.size.height
    }

    /// It is used to add space between given characters as per given parameters. It will call internally `String` function.
    /// - Parameters:
    ///   - spacing: `CGFloat` type value to add space between characters.
    ///   - alignment: `NSTextAlignment` type value to define text alignment.
    ///   - lineBreakMode: `NSLineBreakMode` type value to define line break mode. Default value is **.byTruncatingTail**
    ///   - textFont: `UIFont` object to set font for given string.
    ///   - foregroundColor: `UIColor` object to set color for given string.
    public func addCharacters(_ spacing: CGFloat, alignment: NSTextAlignment = .natural, lineBreakMode: NSLineBreakMode = .byTruncatingTail, textFont: UIFont, foregroundColor: UIColor) {
        if let text = text {
            attributedText = text.addCharacters(spacing, alignment: alignment, lineBreakMode: lineBreakMode, textFont: textFont, foregroundColor: foregroundColor)
        }else if let attributedString = attributedText as? NSMutableAttributedString {
            attributedString.addAttribute(.kern, value: spacing, range: NSMakeRange(0, attributedString.length))
            attributedText = attributedString
        }
    }
    
    /// It is used to add texts and it's attributes.
    /// - Parameters:
    ///   - texts: Array of `String` type.
    ///   - attributes: Array of `[NSAttributedString.Key : Any]` type.
    public func setAttributed(_ texts: [String], attributes: [[NSAttributedString.Key : AnyObject]]) {
        attributedText = NSAttributedString.add(texts, attributes: attributes)
    }
    
    /// It is used to add verticle line space on given texts as per given parameters. It will call internally `String` function.
    /// - Parameters:
    ///   - lineSpacing: `CGFloat` type value to add space.
    ///   - alignment: `NSTextAlignment` type value to define text alignment.
    ///   - lineBreakMode: `NSLineBreakMode` type value to define line break mode. Default value is **.byTruncatingTail**
    ///   - textFont: `UIFont` object to set font for given string.
    ///   - foregroundColor: `UIColor` object to set color for given string.
    public func setVertical(_ lineSpacing: CGFloat, alignment: NSTextAlignment, lineBreakMode: NSLineBreakMode = .byTruncatingTail, textFont: UIFont, foregroundColor: UIColor) {
        if let texts = text {
            attributedText = texts.addVertical(lineSpacing, alignment: alignment, lineBreakMode: lineBreakMode, textFont: textFont, foregroundColor: foregroundColor)
        }else{
            attributedText = nil
        }
    }
    
    /// It is used to draw strike line on given texts. It will call internally `String` function.
    /// - Parameters:
    ///   - color: `UIColor` object to apply color on strike line.
    ///   - textFont: `UIFont` object to set font for given string.
    ///   - foregroundColor: `UIColor` object to set color for given string.
    public func addStrikeThroughLine(_ color: UIColor, textFont: UIFont, foregroundColor: UIColor) {
        if let texts = text {
            attributedText = texts.strikeThroughLine(color, textFont: textFont, foregroundColor: foregroundColor)
        }else{
            attributedText = nil
        }

    }
}
