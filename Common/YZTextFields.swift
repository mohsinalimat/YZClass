//
//  YZTextFields.swift
//  YZLibraries
//
//  Created by Vipul Patel on 15/05/20.
//

import UIKit

//MARK: - Class YZParentWidthTF
/// It is used when, you want to design `UITextField` as per multiple device support and apply `widthRatio`.
public class YZParentWidthTF: UITextField {
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        if let aFont = font {
            font = aFont.withSize(aFont.pointSize * YZAppConfig.widthRatio)
        }
    }
}

//MARK: - Class YZParentHeightTF
/// It is used when, you want to design `UITextField` as per multiple device support and apply `heightRatio`.
public class YZParentHeightTF: UITextField {
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        if let aFont = font {
            font = aFont.withSize(aFont.pointSize * YZAppConfig.heightRatio)
        }
    }
}

//MARK: - Class YZParentPaddingTF
/// It is used to set padding for TextRect, PlaceHolderRect and EditingRect using `UIEdgeInsets`.
public class YZParentPaddingTF: UITextField {
    
    /// It is used to set padding for text rect, place holder rect and editing rect
    public var padding: UIEdgeInsets = .zero
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

//MARK: - UITextField Extension
extension UITextField {
    
    /// It is used to add input accessory view to `UITextField`.
    /// - Parameters:
    ///   - text: `String` type value to define accessory `UIBarButtonItem` text.
    ///   - textFont: `UIFont` type object to define accessory `UIBarButtonItem` font.
    ///   - tintColor: `UIColor` tyepe object to set tint color of accessory `UIBarButtonItem`
    ///   - rect: `CGRect` type object to set frame of accessory `UIBarButtonItem`.
    public func addInputAccessory(_ text: String, textFont: UIFont, tintColor: UIColor? = nil, rect: CGRect = .zero) {
        let barButtonItem: UIBarButtonItem = UIBarButtonItem(title: text, style: .done, target: self, action: #selector(onBarButtonItemTap(_:)))
        barButtonItem.tintColor = tintColor
        let doneToolbar: UIToolbar = UIToolbar(frame: rect)
        doneToolbar.barStyle = .default
        doneToolbar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), barButtonItem]
        doneToolbar.sizeToFit()
        inputAccessoryView = doneToolbar
    }
    
    @objc fileprivate func onBarButtonItemTap(_ sender: UIBarButtonItem) {
        resignFirstResponder()
    }
    
    /// It is used to move the carent to the correct position by removing the trailing whitespace.
    public func fixCaretPosition() {
        selectedTextRange = textRange(from: beginningOfDocument, to: beginningOfDocument)
        selectedTextRange = textRange(from: endOfDocument, to: endOfDocument)
    }
    
    /// It is used to set attributed place holder with given parameteres.
    /// - Parameters:
    ///   - placeHolder: `String` to define place holder texts.
    ///   - color: `UIColor` type object.
    ///   - font: `UIFont` type object.
    public func setAttributed(_ placeHolder: String?, color: UIColor, font: UIFont) {
        if let placeHolder = placeHolder {
            attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [.foregroundColor:color, .font: font])
        }else if let placeholder = placeholder {
            attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor:color, .font: font])
        }else{
            attributedPlaceholder = nil
        }
    }
}
