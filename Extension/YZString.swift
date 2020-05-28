//
//  YZString.swift
//  YZLibraries
//
//  Created by Vipul Patel on 14/05/20.
//

import UIKit
import PhoneNumberKit

//MARK: - Propertie(s)
extension String {
    
    /// It is used to check email address valid or not, it will return `Bool` value.
    public var isEmailAddressValid: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: trimmingCharacters(in: .whitespacesAndNewlines))
    }
    
    /// It is used to trimm characters like white space and new lines, it will return `String` value.
    public var trimmedString: String {return trimmingCharacters(in: .whitespacesAndNewlines)}
    
    /// It is used to check given string has numeric value or not, it will return `Bool` value.
    public var isOnlyNumericValue: Bool {return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))}
    
    /// It is used to convert `String` type value to `Double` type value.
    public var toDouble: Double? {return Double(self)}
    
    /// It is used to convert `String` type value to `Float` type value.
    public var toFloat: Float? {return Float(self)}
    
    /// It is used to convert `String` type value to `Int` type value.
    public var toInt: Int? {return Int(self)}
    
    /// It is used to convert `String` type value to `Int64` type value.
    public var toInt64: Int64? {return Int64(self)}

    /// It is used to convert `String` type value to `Int32` type value.
    public var toInt32: Int32? {return Int32(self)}

    /// It is used to convert `String` type value to `Int16` type value.
    public var toInt16: Int16? {return Int16(self)}

    /// It is used to convert `String` type value to `Int8` type value.
    public var toInt8: Int8? {return Int8(self)}
    
    /// It is used to display string in camel case letter, it will return `String` type value.
    public var camelCaseLetter: String {
        if trimmedString.isEmpty == false {
            let source = self
            if source.contains(" ") {
                let cammel = source.capitalized.replacingOccurrences(of: " ", with: " ")
                return cammel
            } else {
                let first = source.capitalized[..<source.startIndex]
                let rest = String(source.dropFirst())
                return "\(first)\(rest)"
            }
        }else{
            return self
        }
    }

    /// It is used to convert HTML to Attributed String.
    public var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .unicode) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType :  NSAttributedString.DocumentType.html], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    /// It is used to convert HTML to String.
    public var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    /// It is used to get characters from word to display as user avatar.
    public var initialCharactersFromWord: String? {
        let arrOfWords = components(separatedBy: " ")
        var initialCharacters: String? = nil
        if arrOfWords.isEmpty == false {
            for word in arrOfWords {
                if let firstCharacter = word.first {
                    initialCharacters? += String(firstCharacter)
                }
            }
        }
        return initialCharacters?.uppercased()
    }
}

//MARK: - PhoneNumberKit
extension String {
    
    /// It is used to check phoe number is valid or not. It will return `Bool` value.
    public var isPhoneNumberValid: Bool {
        guard let _ = validatePhoneNumber() else {
            return false
        }
        return true
    }

    /// Adjust national number for display by adding leading zero if needed. Used for basic formatting functions.
    public var adjustedNationalNumber: String? {
        let numkit = PhoneNumberKit()
        do{
            let mobile = try numkit.parse(self, ignoreType: true)
            return mobile.adjustedNationalNumber()
        }catch{
            return nil
        }
    }
    
    /// It is used to check phone number is valid or not, if is valid than it will return `PhoneNumber` object.
    /// - Returns: It will return `PhoneNumber` object.
    public func validatePhoneNumber() -> PhoneNumber? {
        var phoneNumber: PhoneNumber? = nil
        let phoneNumberKit = PhoneNumberKit()
        do{
            phoneNumber = try phoneNumberKit.parse(self, ignoreType: false)
            return phoneNumber
        }catch{
            return phoneNumber
        }
    }

    /// Formats a partial string (for use in TextField)
    /// - Returns: It will return `String` type object.
    public func getFormattedMobileString() -> String {
        return PartialFormatter().formatPartial(self)
    }
}

//MARK: - String Extension
extension String {
    
    /// It is used to check given string is contain or not.
    /// - Parameter find: `String` type value.
    /// - Returns: It will return `Bool` type value.
    public func contains(_ find: String) -> Bool{
        return range(of: find, options: .caseInsensitive) != nil
    }

    /// It is used to compare two string.
    /// - Parameter otherString: `String` type value.
    /// - Returns: It will return `Bool` type value.
    public func isEqual(_ otherString: String) -> Bool {
        return compare(otherString) == .orderedSame
    }
    
    /// It is used to calculate single line height for given string based on provided font.
    /// - Parameter font: `UIFont` type object.
    /// - Returns: It will return calculated single height in `CGFloat` type.
    public func singleLineHeightFor(_ font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return boundingBox.height
    }
    
    /// It is used to calculate height for given string based on fixed width.
    /// - Parameters:
    ///   - width: `CGFloat` type value.
    ///   - font: `UIFont` type value.
    /// - Returns: It will return calculated height in `CGFloat` type.
    public func heightForFixed(_ width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return boundingBox.height
    }

    /// It is used to calculate width for given string based on fixed height.
    /// - Parameters:
    ///   - height: `CGFloat` type value.
    ///   - font: `UIFont` type value.
    /// - Returns: It will return calculated width in `CGFloat` type.
    public func widthForFixed(_ height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return boundingBox.width
    }
    
    /// It is used to capitalizing first letter of given string or word.
    public mutating func capitalizingFirstLetter() {
        self = prefix(1).uppercased() + dropFirst()
    }
    
    /// It is used to draw strike line on given string. It will call internally `NSMutableAttributedString` function.
    /// - Parameters:
    ///   - color: `UIColor` object to apply color on strike line.
    ///   - textFont: `UIFont` object to set font for given string.
    ///   - foregroundColor: `UIColor` object to set color for given string.
    /// - Returns: It will return `NSAttributedString` object
    public func strikeThroughLine(_ color: UIColor, textFont: UIFont, foregroundColor: UIColor) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.strikeThroughLine(color, textFont: textFont, foregroundColor: foregroundColor)
        return attributedString
    }

    /// It is used to add verticle line space on given string as per given parameters. It will call internally `NSMutableAttributedString` function.
    /// - Parameters:
    ///   - lineSpacing: `CGFloat` type value to add space.
    ///   - alignment: `NSTextAlignment` type value to define text alignment.
    ///   - lineBreakMode: `NSLineBreakMode` type value to define line break mode. Default value is **.byTruncatingTail**
    ///   - textFont: `UIFont` object to set font for given string.
    ///   - foregroundColor: `UIColor` object to set color for given string.
    /// - Returns: It will return `NSAttributedString` object
    public func addVertical(_ lineSpacing: CGFloat, alignment: NSTextAlignment, lineBreakMode: NSLineBreakMode = .byTruncatingTail, textFont: UIFont, foregroundColor: UIColor) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addVertical(lineSpacing, alignment: alignment, lineBreakMode: lineBreakMode, textFont: textFont, foregroundColor: foregroundColor)
        return attributedString
    }
    
    /// It is used to add space between given characters as per given parameters. It will call internally `NSMutableAttributedString` function.
    /// - Parameters:
    ///   - spacing: `CGFloat` type value to add space between characters.
    ///   - alignment: `NSTextAlignment` type value to define text alignment.
    ///   - lineBreakMode: `NSLineBreakMode` type value to define line break mode. Default value is **.byTruncatingTail**
    ///   - textFont: `UIFont` object to set font for given string.
    ///   - foregroundColor: `UIColor` object to set color for given string.
    /// - Returns: It will return `NSAttributedString`
    public func addCharacters(_ spacing: CGFloat, alignment: NSTextAlignment = .natural, lineBreakMode: NSLineBreakMode = .byTruncatingTail, textFont: UIFont, foregroundColor: UIColor) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addCharacters(spacing, alignment: alignment, lineBreakMode: lineBreakMode, textFont: textFont, foregroundColor: foregroundColor)
        return attributedString
    }
    
    /// It is used to set string alignment, font, foreground color as per given parameter. It will call internally `NSMutableAttributedString` function.
    /// - Parameters:
    ///   - alignment: `NSTextAlignment` type object to define text alignment. Default value is **.natural**.
    ///   - textFont: `UIFont` type object. Default value is **nil**.
    ///   - foregroundColor: `UIColor` type object. Default value is **nil**.
    /// - Returns: It will return `NSAttributedString`.
    public func setString(_ alignment: NSTextAlignment = .natural, textFont: UIFont? = nil, foregroundColor: UIColor? = nil) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttributes(paragraphStyle, textFont: textFont, foregroundColor: foregroundColor, range: NSMakeRange(0, attributedString.length))
        return attributedString
    }

    /// It will use to apply drop shadow effects to characters
    ///
    /// - Parameters:
    ///   - shadowColor: The color of the layer’s shadow. The default value of this property is an **opaque black color**
    ///   - shadowBlurRadius: The blur radius (in points) used to render the layer’s shadow. You specify the radius The default value of this property is **0**.
    ///   - shadowOffset: The offset (in points) of the layer’s shadow. The default value of this property is **(0.0, -3.0)**.
    ///   - shadowOpacity: The opacity of the layer’s shadow. The value in this property must be in the range **0.0 (transparent) to 1.0 (opaque)**. The default value of this property is **0.0**.
    ///   - textFont: `UIFont` object to set font for given string.
    ///   - foregroundColor: `UIColor` object to set color for given string.
    /// - Returns: It will return `NSAttributedString`.
    public func addCharacters(_ shadowColor: UIColor, shadowBlurRadius: CGFloat, shadowOffset: CGSize = .zero, textFont: UIFont, foregroundColor: UIColor) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addCharacters(shadowColor, shadowBlurRadius: shadowBlurRadius, shadowOffset: shadowOffset, textFont: textFont, foregroundColor: foregroundColor)
        return attributedString
    }
}

//MARK: - NSMutableAttributedString Extension
extension NSMutableAttributedString {
    
    /// It is used to add atttributed keys and values as per given parameters.
    /// - Parameters:
    ///   - paragraphStyle: `NSParagraphStyle` type object. Default value is **nil**.
    ///   - textFont: `UIFont` type object. Default value is **nil**.
    ///   - foregroundColor: `UIColor` type object. Default value is **nil**.
    ///   - range: `NSRange` type object.
    fileprivate func addAttributes(_ paragraphStyle: NSParagraphStyle? = nil,
                                           textFont: UIFont? = nil,
                                           foregroundColor: UIColor? = nil,
                                           range: NSRange) {
        
        if let paragraphStyle = paragraphStyle {
            addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        }
        
        if let textFont = textFont {
            addAttribute(.font, value: textFont, range: range)
        }
        
        if let foregroundColor = foregroundColor {
            addAttribute(.foregroundColor, value: foregroundColor, range: range)
        }
    }
    
    /// It is used to set string alignment, as per given parameter.
    /// - Parameter alignment: `NSTextAlignment` type object to define text alignment. Default value is **.natural**.
    fileprivate func setAttributedString(_ alignment: NSTextAlignment = .natural) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, length))
    }
    
    /// It is used to draw strike line on given string.
    /// - Parameters:
    ///   - color: `UIColor` object to apply color on strike line.
    ///   - textFont: `UIFont` object to set font for given string.
    ///   - foregroundColor: `UIColor` object to set color for given string.
    fileprivate func strikeThroughLine(_ color: UIColor,
                                  textFont: UIFont,
                                  foregroundColor: UIColor) {
        let range = NSMakeRange(0, length)
        addAttribute(.strikethroughStyle, value: NSNumber(integerLiteral: NSUnderlineStyle.single.rawValue), range: range)
        addAttribute(.strikethroughColor, value: color, range: range)
        addAttributes(textFont: textFont, foregroundColor: foregroundColor, range: range)
    }
    
    /// It is used to add verticle line space on given string as per given parameters.
    /// - Parameters:
    ///   - lineSpacing: `CGFloat` type value to add space.
    ///   - alignment: `NSTextAlignment` type value to define text alignment.
    ///   - lineBreakMode: `NSLineBreakMode` type value to define line break mode. Default value is **.byTruncatingTail**
    ///   - textFont: `UIFont` object to set font for given string.
    ///   - foregroundColor: `UIColor` object to set color for given string.
    fileprivate func addVertical(_ lineSpacing: CGFloat,
                            alignment: NSTextAlignment = .natural,
                            lineBreakMode: NSLineBreakMode = .byTruncatingTail,
                            textFont: UIFont,
                            foregroundColor: UIColor) {

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = alignment
        paragraphStyle.lineBreakMode = lineBreakMode
        
        addAttributes(paragraphStyle, textFont: textFont, foregroundColor: foregroundColor, range: NSMakeRange(0, length))
    }
    
    /// It is used to add space between given characters as per given parameters.
    /// - Parameters:
    ///   - spacing: `CGFloat` type value to add space between characters.
    ///   - alignment: `NSTextAlignment` type value to define text alignment.
    ///   - lineBreakMode: `NSLineBreakMode` type value to define line break mode. Default value is **.byTruncatingTail**
    ///   - textFont: `UIFont` object to set font for given string.
    ///   - foregroundColor: `UIColor` object to set color for given string.
    fileprivate func addCharacters(_ spacing: CGFloat,
                       alignment: NSTextAlignment = .natural,
                       lineBreakMode: NSLineBreakMode = .byTruncatingTail,
                       textFont: UIFont,
                       foregroundColor: UIColor) {
        let range = NSMakeRange(0, length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        
        addAttribute(.kern, value: spacing, range: range)
        addAttributes(paragraphStyle, textFont: textFont, foregroundColor: foregroundColor, range: range)
    }
    
    /// It will use to apply drop shadow effects to characters
    ///
    /// - Parameters:
    ///   - shadowColor: The color of the layer’s shadow. The default value of this property is an **opaque black color**
    ///   - shadowBlurRadius: The blur radius (in points) used to render the layer’s shadow. You specify the radius The default value of this property is **0**.
    ///   - shadowOffset: The offset (in points) of the layer’s shadow. The default value of this property is **(0.0, -3.0)**.
    ///   - shadowOpacity: The opacity of the layer’s shadow. The value in this property must be in the range **0.0 (transparent) to 1.0 (opaque)**. The default value of this property is **0.0**.
    ///   - textFont: `UIFont` object to set font for given string.
    ///   - foregroundColor: `UIColor` object to set color for given string.
    fileprivate func addCharacters(_ shadowColor: UIColor,
                       shadowBlurRadius: CGFloat,
                       shadowOffset: CGSize = .zero,
                       textFont: UIFont,
                       foregroundColor: UIColor) {
        let shadow = NSShadow()
        shadow.shadowColor = shadowColor
        shadow.shadowBlurRadius = shadowBlurRadius
        shadow.shadowOffset = shadowOffset
        
        let range = NSMakeRange(0, length)
        addAttribute(.font, value: textFont, range: range)
        addAttribute(.foregroundColor, value: foregroundColor, range: range)
        addAttribute(.shadow, value: shadow, range: range)
    }
}

//MARK: - NSAttributedString Extension
extension NSAttributedString {

    /// It is used to get width for given attributed string.
    public var width: CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        return boundingBox.width
    }
    
    /// It is used to get single line height for given attributed string.
    public var singleLineHeight: CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        return ceil(boundingBox.height)
    }
        
    /// It is used to get height for given attributed string.
    public func heightForFixed(_ width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        return ceil(boundingBox.height)
    }
    
    /// It is class based static function and used to append right side attributed string result to left side attributed string result.
    /// - Parameters:
    ///   - left: `NSAttributedString` type value.
    ///   - right: `NSAttributedString` type value.
    /// - Returns: It will return `NSAttributedString`.
    public static func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
        let result = NSMutableAttributedString()
        result.append(left)
        result.append(right)
        return result
    }
    
    /// It is class based static function and used to add texts and it's attributes.
    /// - Parameters:
    ///   - texts: Array of `String` type.
    ///   - attributes: Array of `[NSAttributedString.Key : Any]` type.
    /// - Returns: It will return `NSAttributedString`.
    public static func add(_ texts: [String], attributes: [[NSAttributedString.Key : Any]]) -> NSAttributedString {
        let attributedString = NSMutableAttributedString()
        for (index,element) in texts.enumerated() {
            attributedString.append(NSAttributedString(string: element, attributes: attributes[index]))
        }
        return attributedString
    }
    
    /// It is used to insert special character to given string list like bullet point.
    /// - Parameters:
    ///   - specialCharacter: The unicode character to display in each line.
    ///   - stringList: The list of string or array of string.
    ///   - defaultTabInterval: The document-wide default tab interval.
    ///   - firstLineHeadIndent: The indentation of the first line of the receiver.
    ///   - lineSpacing: The distance in points between the bottom of one line fragment and the top of the next.
    ///   - paragraphSpacing: The space after the end of the paragraph.
    ///   - headIndent: The indentation of the receiver’s lines other than the first.
    ///   - tailIndent: The trailing indentation of the receiver.
    ///   - specialCharacterColor: `UIColor` object to set color for given special character.
    ///   - textFont: `UIFont` object to set font for given string.
    ///   - foregroundColor: `UIColor` object to set color for given string.
    /// - Returns: It will return `NSAttributedString`.
    public static func insert( specialCharacter: String = "\u{2022}",
                 stringList: [String],
                 defaultTabInterval: CGFloat = .leastNormalMagnitude,
                 firstLineHeadIndent: CGFloat = .leastNormalMagnitude,
                 lineSpacing: CGFloat = 0.5,
                 paragraphSpacing: CGFloat = 2,
                 headIndent: CGFloat = 15,
                 tailIndent: CGFloat = 15,
                 specialCharacterColor: UIColor,
                 textFont: UIFont,
                 foregroundColor: UIColor) -> NSAttributedString {

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: defaultTabInterval, options: [:])]
        paragraphStyle.defaultTabInterval = defaultTabInterval
        paragraphStyle.firstLineHeadIndent = firstLineHeadIndent
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.paragraphSpacing = paragraphSpacing
        paragraphStyle.headIndent = headIndent
        paragraphStyle.tailIndent = tailIndent

        let textAttributes: [NSAttributedString.Key: Any] = [.font: textFont, .foregroundColor: foregroundColor]
        let bulletAttributes: [NSAttributedString.Key: Any] = [.font: textFont, .foregroundColor: specialCharacterColor]
        let bulletList = NSMutableAttributedString()
        
        for string in stringList {
            let formattedString = "\(specialCharacter)\t\(string)\n"
            let attributedString = NSMutableAttributedString(string: formattedString)

            attributedString.addAttributes(
                [NSAttributedString.Key.paragraphStyle : paragraphStyle],
                range: NSMakeRange(0, attributedString.length))

            attributedString.addAttributes(
                textAttributes,
                range: NSMakeRange(0, attributedString.length))

            let string:NSString = NSString(string: formattedString)
            let rangeForBullet:NSRange = string.range(of: specialCharacter)
            attributedString.addAttributes(bulletAttributes, range: rangeForBullet)
            bulletList.append(attributedString)
        }

        return bulletList
    }
}
