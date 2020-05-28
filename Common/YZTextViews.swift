//
//  YZTextViews.swift
//  YZLibraries
//
//  Created by Vipul Patel on 21/04/20.
//

import UIKit

//MARK: - Class YZParentWidthTV
/// It is used when, you want to design `UITextView` as per multiple device support and apply `widthRatio`.
public class YZParentWidthTV: UITextView {
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        if let aFont = font {
            font = aFont.withSize(aFont.pointSize * YZAppConfig.widthRatio)
        }
    }
}

//MARK: - Class YZParentHeightTV
/// It is used when, you want to design `UITextView` as per multiple device support and apply `heightRatio`.
public class YZParentHeightTV: UITextView {
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        if let aFont = font {
            font = aFont.withSize(aFont.pointSize * YZAppConfig.heightRatio)
        }
    }
}

//MARK: - Class YZWithoutInsetTV
/// It is used when, you want to design `UITextView` without any additional insets or padding.
public class YZWithoutInsetTV: UITextView {
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        removeInsets()
    }
}

//MARK: - Protocol YZLinkableTVDelegate
/// It is used when, you want to get value for `UIDataDetectorTypes`.
public protocol YZLinkableTVDelegate: class {
    func didTapOn(_ link: String, textView: UITextView, anyObject: Any?)
}

//MARK: - Class YZLinkableTV
/// It is used when, you want to get value for `UIDataDetectorTypes`.
public class YZLinkableTV: YZWithoutInsetTV, UITextViewDelegate {
    public var linkableDelegate: YZLinkableTVDelegate?
    public var anyObject: Any?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        delegate = self
        isScrollEnabled = false
        isEditable = false
        isSelectable = true
        removeInsets()
    }
    
    public override var canBecomeFirstResponder: Bool { return false }
    
    public override var canBecomeFocused: Bool { return false }
    
    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        linkableDelegate?.didTapOn(URL.absoluteString, textView: self, anyObject: anyObject)
        return true
    }
}


//MARK: - UITextView Extension
extension UITextView {
    /**
     Calculates if new textview height (based on content) is larger than a base height
     - parameter baseHeight: The base or minimum height
     - returns: The new height
     */
    public func newHeightUsing(_ baseHeight: CGFloat) -> CGFloat {
        
        // Calculate the required size of the textview
        let fixedWidth = frame.size.width
        let newSize = sizeThatFits(CGSize(width: fixedWidth, height: .greatestFiniteMagnitude))
        var newFrame = frame
        
        // Height is always >= the base height, so calculate the possible new height
        let height: CGFloat = newSize.height > baseHeight ? newSize.height : baseHeight
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: height)
        
        return newFrame.height
    }
    
    /// It is used to remove insets.
    public func removeInsets() {
        textContainerInset = UIEdgeInsets.zero
        textContainer.lineFragmentPadding = 0
    }
    
    /// It is used to add input accessory view to `UITextView`.
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
}
