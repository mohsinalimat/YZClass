//
//  YZConstrainedViews.swift
//  YZLibraries
//
//  Created by Vipul Patel on 18/05/20.
//

import UIKit

//MARK: - Class YZUserTapDelegate
/// It is used to get user tap event on text for tableCell, collectionCell, and headerFooter views.
@objc public protocol YZUserTapDelegate: class {
    @objc optional func didTapOn(_ text: String, tableCell: YZParentTVC?, anyObject: Any?)
    @objc optional func didTapOn(_ text: String, collectionCell: YZParentCVC?, anyObject: Any?)
    @objc optional func didTapOn(_ text: String, headerFooter: YZParentHFV?, anyObject: Any?)
}

//MARK: - Protocol YZTextFieldDelegate
/// It is used to get `UITextField` events.
@objc public protocol YZTextFieldDelegate: class {
    @objc optional func textFieldDidChange(_ tableCell: YZParentTVC, anyObject: Any?)
    @objc optional func textFieldShouldReturn(_ tableCell: YZParentTVC?, anyObject: Any?) -> Bool
}

//MARK: - Class YZParentControl
/// It is a sub-class of `UIControl` use to set as parent class.
open class YZParentControl: UIControl {
    @IBOutlet public weak var viewContainer: UIView?
    @IBOutlet public var constraintHeightOfSeparator: NSLayoutConstraint?
    @IBOutlet public var horizontalConstraints: [NSLayoutConstraint]?
    @IBOutlet public var verticalConstraints: [NSLayoutConstraint]?
    public static var identifier: String {return String(describing: self)}
    public static var nib: UINib {return UINib(nibName: identifier, bundle: nil)}

    open override func awakeFromNib() {
        super.awakeFromNib()
        constraintUpdate()
    }
    
    open override func layoutSubviews() {super.layoutSubviews()}

    func constraintUpdate() {
        if let hConts = horizontalConstraints {
            for const in hConts {
                let v1 = const.constant
                let v2 = v1 * YZAppConfig.widthRatio
                const.constant = v2
            }
        }
        if let vConst = verticalConstraints {
            for const in vConst {
                let v1 = const.constant
                let v2 = v1 * YZAppConfig.heightRatio
                const.constant = v2
            }
        }
    }
}


//MARK: - Class YZParentCVC
/// It is a sub-class of `UICollectionViewCell` use to set as parent class.
open class YZParentCVC: UICollectionViewCell {
    @IBOutlet public weak var viewContainer: UIView?
    @IBOutlet public var constraintHeightOfSeparator: NSLayoutConstraint?
    @IBOutlet public var horizontalConstraints: [NSLayoutConstraint]?
    @IBOutlet public var verticalConstraints: [NSLayoutConstraint]?
    public static var identifier: String {return String(describing: self)}
    public static var nib: UINib {return UINib(nibName: identifier, bundle: nil)}

    open override func awakeFromNib() {
        super.awakeFromNib()
        constraintUpdate()
    }
    
    open override func layoutSubviews() {super.layoutSubviews()}

    func constraintUpdate() {
        if let hConts = horizontalConstraints {
            for const in hConts {
                let v1 = const.constant
                let v2 = v1 * YZAppConfig.widthRatio
                const.constant = v2
            }
        }
        if let vConst = verticalConstraints {
            for const in vConst {
                let v1 = const.constant
                let v2 = v1 * YZAppConfig.heightRatio
                const.constant = v2
            }
        }
    }
}

//MARK: - Class YZParentCRV
/// It is a sub-class of `UICollectionReusableView` use to set as parent class.
open class YZParentCRV: UICollectionReusableView {
    @IBOutlet public weak var viewContainer: UIView?
    @IBOutlet public var constraintHeightOfSeparator: NSLayoutConstraint?
    @IBOutlet public var horizontalConstraints: [NSLayoutConstraint]?
    @IBOutlet public var verticalConstraints: [NSLayoutConstraint]?
    public static var identifier: String {return String(describing: self)}
    public static var nib: UINib {return UINib(nibName: identifier, bundle: nil)}

    open override func awakeFromNib() {
        super.awakeFromNib()
        constraintUpdate()
    }
    
    open override func layoutSubviews() {super.layoutSubviews()}

    func constraintUpdate() {
        if let hConts = horizontalConstraints {
            for const in hConts {
                let v1 = const.constant
                let v2 = v1 * YZAppConfig.widthRatio
                const.constant = v2
            }
        }
        if let vConst = verticalConstraints {
            for const in vConst {
                let v1 = const.constant
                let v2 = v1 * YZAppConfig.heightRatio
                const.constant = v2
            }
        }
    }
}

//MARK: - Class YZParentHFV
/// It is a sub-class of `UITableViewHeaderFooterView` use to set as parent class.
open class YZParentHFV: UITableViewHeaderFooterView {
    @IBOutlet public weak var viewContainer: UIView?
    @IBOutlet public var constraintHeightOfSeparator: NSLayoutConstraint?
    @IBOutlet public var horizontalConstraints: [NSLayoutConstraint]?
    @IBOutlet public var verticalConstraints: [NSLayoutConstraint]?
    public static var identifier: String {return String(describing: self)}
    public static var nib: UINib {return UINib(nibName: identifier, bundle: nil)}

    open override func awakeFromNib() {
        super.awakeFromNib()
        constraintUpdate()
    }
    
    open override func layoutSubviews() {super.layoutSubviews()}

    func constraintUpdate() {

        if let heightOfSperator = constraintHeightOfSeparator {
            heightOfSperator.constant = 0.5
        }
        
        if let hConts = horizontalConstraints {
            for const in hConts {
                let v1 = const.constant
                let v2 = v1 * YZAppConfig.widthRatio
                const.constant = v2
            }
        }
        if let vConst = verticalConstraints {
            for const in vConst {
                let v1 = const.constant
                let v2 = v1 * YZAppConfig.heightRatio
                const.constant = v2
            }
        }
    }
}

//MARK: - Class YZParentTVC
/// It is a sub-class of `UITableViewCell` use to set as parent class.
open class YZParentTVC: UITableViewCell {
    @IBOutlet public weak var viewContainer: UIView?
    @IBOutlet public var constraintHeightOfSeparator: NSLayoutConstraint?
    @IBOutlet public var horizontalConstraints: [NSLayoutConstraint]?
    @IBOutlet public var verticalConstraints: [NSLayoutConstraint]?
    public static var identifier: String {return String(describing: self)}
    public static var nib: UINib {return UINib(nibName: identifier, bundle: nil)}

    open override func awakeFromNib() {
        super.awakeFromNib()
        constraintUpdate()
    }
    
    open override func layoutSubviews() {super.layoutSubviews()}

    func constraintUpdate() {

        if let heightOfSperator = constraintHeightOfSeparator {
            heightOfSperator.constant = 0.67
        }
        
        if let hConts = horizontalConstraints {
            for const in hConts {
                let v1 = const.constant
                let v2 = v1 * YZAppConfig.widthRatio
                const.constant = v2
            }
        }
        if let vConst = verticalConstraints {
            for const in vConst {
                let v1 = const.constant
                let v2 = v1 * YZAppConfig.heightRatio
                const.constant = v2
            }
        }
    }
}

//MARK: - Class YZParentView
/// It is a sub-class of `UIView` use to set as parent class.
open class YZParentView: UIView {
    @IBOutlet public weak var viewContainer: UIView?
    @IBOutlet public var constraintHeightOfSeparator: NSLayoutConstraint?
    @IBOutlet public var horizontalConstraints: [NSLayoutConstraint]?
    @IBOutlet public var verticalConstraints: [NSLayoutConstraint]?
    public static var identifier: String {return String(describing: self)}
    public static var nib: UINib {return UINib(nibName: identifier, bundle: nil)}

    open override func awakeFromNib() {
        super.awakeFromNib()
        constraintUpdate()
    }
    
    open override func layoutSubviews() {super.layoutSubviews()}

    func constraintUpdate() {
        if let hConts = horizontalConstraints {
            for const in hConts {
                let v1 = const.constant
                let v2 = v1 * YZAppConfig.widthRatio
                const.constant = v2
            }
        }
        if let vConst = verticalConstraints {
            for const in vConst {
                let v1 = const.constant
                let v2 = v1 * YZAppConfig.heightRatio
                const.constant = v2
            }
        }
    }
}
