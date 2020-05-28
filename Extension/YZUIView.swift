//
//  YZUIView.swift
//  YZLibraries
//
//  Created by Vipul Patel on 21/04/20.
//

import Foundation

//MARK: - UIView IBInspectable(s)
public extension UIView {

    /// `@IBInspectable isRound` property is used to draw fully round on selected `UIView`.
    @IBInspectable var isRound: Bool {
        get { return (layer.cornerRadius == (frame.size.width/2) ) || (layer.cornerRadius == (frame.size.height/2)) }
        set { layer.cornerRadius = newValue == true ? (frame.size.height/2) : layer.cornerRadius }
    }
    
    /// `@IBInspectable borderWidth` property is used to draw border around on selected `UIView`.
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    /// `@IBInspectable borderColor` property is used to apply border color on selected `UIView`.
    @IBInspectable var borderColor: UIColor {
        get { return layer.borderColor == nil ? UIColor.clear : UIColor(cgColor: layer.borderColor!) }
        set { layer.borderColor = newValue.cgColor }
    }
    
    /// `@IBInspectable cornerRadius` property is used to apply corner radius on selected `UIView`.
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    /// `@IBInspectable shadowRadius` property is used to define shadow radius on selected `UIView`.
    @IBInspectable var shadowRadius: CGFloat {
        get { return layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }
    
    /// `@IBInspectable shadowOpacity` property is used to define shadow opacity on selected `UIView`.
    @IBInspectable var shadowOpacity: Float {
        get { return layer.shadowOpacity }
        set { layer.shadowOpacity = newValue }
    }
    
    /// `@IBInspectable shadowColor` property is used to define shadow color on selected `UIView`.
    @IBInspectable var shadowColor: UIColor? {
        get { return layer.shadowColor != nil ? UIColor(cgColor: layer.shadowColor!) : nil }
        set { layer.shadowColor = newValue?.cgColor }
    }
    
    /// `@IBInspectable shadowOffset` property is used to define shadow offsets on selected `UIView`.
    @IBInspectable var shadowOffset: CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }

    /// `@IBInspectable zPosition` property is used to define `zPosition`.
    @IBInspectable var zPosition: CGFloat {
        get { return layer.zPosition }
        set { layer.zPosition = newValue }
    }
}

//MARK: - UIView Shadow(s) and CornerRadius(s)
/// UIView extensiton to add shadow on UIView layer.
extension UIView {

    /// It will use to add cornder radius around `UIView`, with specific parameters.
    /// - Parameters:
    ///   - roundingCorners: The rounding corners of UIView. Defaults to **[.allCorners]**.
    ///   - cornerRadii: The corner raddi size. Default to **.zero**.
    ///   - fillColor: The color used to fill the shape’s path. Setting **fillColor to nil** results in no fill being rendered. Default is **opaque black**.
    public func addCornerRadiusBy(_ roundingCorners: UIRectCorner = [.allCorners],
                                  cornerRadii: CGSize = .zero,
                                  fillColor: UIColor? = .black) {
        layer.addCornerRadiusBy(roundingCorners, cornerRadii: cornerRadii, fillColor: fillColor)
    }

    /// It will use to draw a shadow around `UIView`, with specific parameters.
    /// - Parameters:
    ///   - shadowOffset: The offset (in points) of the layer’s shadow. The default value of this property is **(0.0, -3.0)**.
    ///   - shadowColor: The color of the layer’s shadow. The default value of this property is an **opaque black color**
    ///   - shadowRadius: The blur radius (in points) used to render the layer’s shadow. You specify the radius The default value of this property is **3**.
    ///   - shadowOpacity: The opacity of the layer’s shadow. The value in this property must be in the range **0.0 (transparent) to 1.0 (opaque)**. The default value of this property is **0.0**.
    public func applyShadowWith(_ shadowOffset: CGSize = .zero,
                                shadowColor: UIColor,
                                shadowRadius: CGFloat = 3,
                                shadowOpacity:Float = 0) {
        layer.applyShadowWith(shadowOffset, shadowColor: shadowColor, shadowRadius: shadowRadius, shadowOpacity: shadowOpacity)
    }
    
    /// It will use to draw a shadow around `UIView`, with specific parameters.
    /// - Parameters:
    ///   - roundingCorners: The rounding corners of UIView. Defaults to **[.allCorners]**.
    ///   - cornerRadii: The corner raddi size. Default to **.zero**.
    ///   - fillColor: The color used to fill the shape’s path. Setting **fillColor to nil** results in no fill being rendered. Default is **opaque black**.
    ///   - shadowOffset: The offset (in points) of the layer’s shadow. The default value of this property is **(0.0, -3.0)**.
    ///   - shadowColor: The color of the layer’s shadow. The default value of this property is an **opaque black color**
    ///   - shadowRadius: The blur radius (in points) used to render the layer’s shadow. You specify the radius The default value of this property is **3**.
    ///   - shadowOpacity: The opacity of the layer’s shadow. The value in this property must be in the range **0.0 (transparent) to 1.0 (opaque)**. The default value of this property is **0.0**.
    public func applyShadowWith(_ roundingCorners: UIRectCorner = [.allCorners],
                                cornerRadii: CGSize = .zero,
                                fillColor: UIColor? = nil,
                                shadowOffset: CGSize = .zero,
                                shadowColor: UIColor,
                                shadowRadius: CGFloat = 3,
                                shadowOpacity:Float = 0) {
        layer.applyShadowWith(roundingCorners, cornerRadii: cornerRadii, fillColor: fillColor, shadowOffset: shadowOffset, shadowColor: shadowColor, shadowRadius: shadowRadius, shadowOpacity: shadowOpacity)
    }
}

//MARK: - UIView Constraint(s)
/// UIView extensiton to add constraint on child `UIView` with super UIView.
extension UIView {
    
    /// It will use to add constraint with superView.
    /// - Parameters:
    ///   - topConstraint: CGFloat type value, topConstraint from super view.
    ///   - leadingConstraint: CGFloat type value, trailingConstraint from super view.
    ///   - bottomConstraint: CGFloat type value, bottomConstraint from super view.
    ///   - trailingConstraint: CGFloat type value, leadingConstraint from super view.
    public func addConstraintWithSuperView(_ topConstraint: CGFloat,
                                           leadingConstraint: CGFloat,
                                           bottomConstraint: CGFloat,
                                           trailingConstraint: CGFloat) {
        if let superView = superview {
            let topSpace = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview!, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: topConstraint)
            let leadingSpace = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview!, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: leadingConstraint)
            let bottomSpace = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview!, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: bottomConstraint)
            let trailingSpace = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview!, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: trailingConstraint)
            translatesAutoresizingMaskIntoConstraints = false
            superView.addConstraints([topSpace, leadingSpace, bottomSpace, trailingSpace])
        }
    }
}

//MARK: - UIView Border(s)
/// UIView extensiton to add constraint on child `UIView` with super UIView.
extension UIView {
    
    /// It will use to draw a border around `UIView`, with specific parameters.
    /// - Parameters:
    ///   - roundingCorners: The rounding corners of UIView. Defaults to **[.allCorners]**.
    ///   - cornerRadii: The corner raddi size. Default to **.zero**.
    ///   - fillColor: The color used to fill the shape’s path. Setting **fillColor to nil** results in no fill being rendered. Default is **opaque black**.
    ///   - strokeColor: The color used to stroke the shape’s path. Setting strokeColor to nil results in no stroke being rendered. Default is **nil**
    ///   - lineWidth: Specifies the line width of the shape’s path. Default value is **1**
    public func addBorderBy(_ roundingCorners: UIRectCorner = [.allCorners],
                     cornerRadii: CGSize = .zero,
                     fillColor: UIColor? = .black,
                     strokeColor: UIColor? = nil,
                     lineWidth: CGFloat = 1) {
        layer.addBorderBy(roundingCorners, cornerRadii: cornerRadii, fillColor: fillColor, strokeColor: strokeColor, lineWidth: lineWidth)
    }
    
    /// It will use to draw a dash border around `UIView`, with specific parameters.
    /// - Parameters:
    ///   - cornerRadius: The corner radius value. Default to **.leastNonzeroMagnitude**.
    ///   - fillColor: The color used to fill the shape’s path. Setting **fillColor to nil** results in no fill being rendered. Default is **opaque black**.
    ///   - dashColor: The color used to stroke the shape’s path. Setting **strokeColor to nil** results in no stroke being rendered. Default is **nil**.
    ///   - dashHeight: Specifies the line height of the shape’s path. Default to **one**.
    ///   - dashWidth: The dash line width value. Default to **five**.
    ///   - spaceBetweenDash: The space between two dash value. Default to **five**.
    public func addDashBorderBy(_ cornerRadius: CGFloat = .leastNonzeroMagnitude,
                         fillColor: UIColor? = .black,
                         dashColor: UIColor? = nil,
                         dashHeight: CGFloat = 1,
                         dashWidth: CGFloat = 5,
                         spaceBetweenDash: CGFloat = 5) {
        layer.addDashBorderBy(cornerRadius, fillColor: fillColor, dashColor: dashColor, dashHeight: dashHeight, dashWidth: dashWidth, spaceBetweenDash: spaceBetweenDash)
    }
}

//MARK: - UIView Gradient(s)
/// UIView extensiton to add gradient on UIView layer.
extension UIView {
    
    /// It will use to add gradient colors inside `UIView`, with specific parameters.
    /// - Parameters:
    ///   - colors: The collection of colors to add gradeints.
    ///   - gradientPoint: The gradient point to draw gradients.
    public func addGradient(_ colors: [UIColor],
                            gradientPoint: YZGradientPoint) {
        layer.addGradient(colors, gradientPoint: gradientPoint)
    }
    
    /// It will use to add gradient colors inside `UIView`, with specific parameters.
    /// - Parameters:
    ///   - colors: The collection of colors to add gradeints.
    ///   - gradientPoint: The gradient point to draw gradients.
    ///   - roundingCorners: The rounding corners of UIView. Defaults to **[.allCorners]**.
    ///   - cornerRadii: The corner raddi size. Default to **.zero**.
    public func addGradient(_ colors: [UIColor],
                            gradientPoint: YZGradientPoint,
                            roundingCorners: UIRectCorner = [.allCorners],
                            cornerRadii: CGSize = .zero) {
        layer.addGradient(colors, gradientPoint: gradientPoint, roundingCorners: roundingCorners, cornerRadii: cornerRadii)
    }
}
