//
//  YZButtons.swift
//  YZLibraries
//
//  Created by Vipul Patel on 21/04/20.
//

import UIKit

//MARK: - Class YZParentWidthBTN
/// It is used when, you want to design `UIButton` as per multiple device support and apply `widthRatio`.
public class YZParentWidthBTN: UIButton {

    public override func awakeFromNib() {
        super.awakeFromNib()
        if let aFont = titleLabel?.font {
            titleLabel?.font = aFont.withSize(aFont.pointSize * YZAppConfig.widthRatio)
        }
    }
}

//MARK: - Class YZParentHeightBTN
/// It is used when, you want to design `UIButton` as per multiple device support and apply `heightRatio`.
public class YZParentHeightBTN: UIButton {
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        if let aFont = titleLabel?.font {
            titleLabel?.font = aFont.withSize(aFont.pointSize * YZAppConfig.heightRatio)
        }
    }
}

//MARK: - UIButton Extension
extension UIButton {
    
    /// It is used to set texts and it's attributes as per given parameters. It will internally call `NSAttributedString` function.
    /// - Parameters:
    ///   - texts: Array of `String` type.
    ///   - attributes: Array of `[NSAttributedString.Key : Any]` type.
    ///   - state: `UIControl.State` of button.
    public func setAttributed(_ texts: [String], attributes: [[NSAttributedString.Key : Any]], state: UIControl.State) {
        setAttributedTitle(NSAttributedString.add(texts, attributes: attributes), for: state)
    }
}
