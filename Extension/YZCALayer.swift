//
//  YZCALayer.swift
//  YZLibraries
//
//  Created by Vipul Patel on 14/05/20.
//

import Foundation

//MARK: - CALayer CornerRadius
/// CALayer extensiton to add corner radius using CAShapeLayer to any CALayer.
extension CALayer {
    
    /// It will use to add cornder radius using `CAShapeLayer`, with specific parameters.
    /// - Parameters:
    ///   - roundingCorners: The rounding corners of UIView. Defaults to **[.allCorners]**.
    ///   - cornerRadii: The corner raddi size. Default to **.zero**.
    ///   - fillColor: The color used to fill the shape’s path. Setting **fillColor to nil** results in no fill being rendered. Default is **opaque black**.
    public func addCornerRadiusBy(_ roundingCorners: UIRectCorner = [.allCorners],
                           cornerRadii: CGSize = .zero,
                           fillColor: UIColor? = .black) {
        if let subLayers = sublayers, subLayers.isEmpty == false {
            for layer in subLayers {
                if layer is CAShapeLayer {
                    layer.removeFromSuperlayer()
                    break
                }
            }
        }
        
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: roundingCorners, cornerRadii: cornerRadii)
        let layerRadius = CAShapeLayer()
        layerRadius.path = maskPath.cgPath
        layerRadius.fillColor = fillColor?.cgColor
        
        insertSublayer(layerRadius, at: 0)
    }
}

//MARK: - CALayer Shadow
/// CALayer extensiton to add shadow to any CALayer.
extension CALayer {
    
    /// It will use to draw a shadow around CALayer, with specific parameters.
    /// - Parameters:
    ///   - shadowOffset: The offset (in points) of the layer’s shadow. The default value of this property is **(0.0, -3.0)**.
    ///   - shadowColor: The color of the layer’s shadow. The default value of this property is an **opaque black color**
    ///   - shadowRadius: The blur radius (in points) used to render the layer’s shadow. You specify the radius The default value of this property is **3**.
    ///   - shadowOpacity: The opacity of the layer’s shadow. The value in this property must be in the range **0.0 (transparent) to 1.0 (opaque)**. The default value of this property is **0.0**.
    public func applyShadowWith(_ shadowOffset: CGSize = .zero,
                              shadowColor: UIColor,
                              shadowRadius: CGFloat = 3,
                              shadowOpacity:Float = 0) {
        self.shadowOffset = shadowOffset
        self.shadowColor = shadowColor.cgColor
        self.shadowRadius = shadowRadius
        self.shadowOpacity = shadowOpacity
        self.masksToBounds = false
    }

    /// It will use to draw a shadow using `CAShapeLayer`, with specific parameters.
    /// - Parameters:
    ///   - roundingCorners: The rounding corners of UIView. Defaults to **[.allCorners]**.
    ///   - cornerRadii: The corner raddi size. Default to **.zero**.
    ///   - fillColor: The color used to fill the shape’s path. Setting **fillColor to nil** results in no fill being rendered. Default is **opaque black**.
    ///   - shadowOffset: The offset (in points) of the layer’s shadow. The default value of this property is **(0.0, -3.0)**.
    ///   - shadowColor: The color of the layer’s shadow. The default value of this property is an **opaque black color**
    ///   - shadowRadius: The blur radius (in points) used to render the layer’s shadow. You specify the radius The default value of this property is **3**.
    ///   - shadowOpacity: The opacity of the layer’s shadow. The value in this property must be in the range **0.0 (transparent) to 1.0 (opaque)**. The default value of this property is **0.0**.
    public func applyShadowWith(_ roundingCorners: UIRectCorner = [.allCorners],
                              cornerRadii: CGSize = .zero, fillColor: UIColor? = nil,
                              shadowOffset: CGSize = .zero,
                              shadowColor: UIColor, shadowRadius: CGFloat = 3,
                              shadowOpacity:Float = 0) {
        if let subLayers = sublayers, subLayers.isEmpty == false {
            for layer in subLayers {
                if layer is CAShapeLayer {
                    layer.removeFromSuperlayer()
                    break
                }
            }
        }

        let layerShadow = CAShapeLayer()
        let cgPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: roundingCorners, cornerRadii: cornerRadii).cgPath
        layerShadow.path = cgPath
        layerShadow.fillColor = fillColor?.cgColor
        layerShadow.shadowPath = cgPath
        layerShadow.applyShadowWith(shadowOffset, shadowColor: shadowColor, shadowRadius: shadowRadius, shadowOpacity: shadowOpacity)
        insertSublayer(layerShadow, at: 0)
    }
}

//MARK: - UIView Border(s)
/// CALayer extensiton to add border using CAShapeLayer to any CALayer.
extension CALayer {
    
    /// It will use to draw a border using `CAShapeLayer`, with specific parameters.
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
        if let subLayers = sublayers, subLayers.isEmpty == false {
            for layer in subLayers {
                if layer is CAShapeLayer {
                    layer.removeFromSuperlayer()
                    break
                }
            }
        }
        
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: roundingCorners, cornerRadii: cornerRadii)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = maskPath.cgPath
        mask = shapeLayer
        
        let layerBorder = CAShapeLayer()
        layerBorder.path = maskPath.cgPath
        layerBorder.strokeColor = strokeColor?.cgColor
        layerBorder.fillColor = fillColor?.cgColor
        layerBorder.lineWidth = lineWidth
        layerBorder.frame = bounds
        
        insertSublayer(layerBorder, at: 0)
    }
    
    /// It will use to draw a dash border using `CAShapeLayer`, with specific parameters.
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
        
        if let subLayers = sublayers, subLayers.isEmpty == false {
            for layer in subLayers {
                if layer is CAShapeLayer {
                    layer.removeFromSuperlayer()
                }
            }
        }
        self.cornerRadius = cornerRadius
        
        let layerDashBorder = CAShapeLayer()
        layerDashBorder.lineWidth = dashHeight
        layerDashBorder.strokeColor = dashColor?.cgColor
        layerDashBorder.lineDashPattern = [dashWidth, spaceBetweenDash] as [NSNumber]
        layerDashBorder.frame = bounds
        layerDashBorder.fillColor = fillColor?.cgColor
        
        if cornerRadius > 0 {
            masksToBounds = true
            let cgPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            layerDashBorder.path = cgPath
        } else {
            masksToBounds = false
            layerDashBorder.path = UIBezierPath(rect: bounds).cgPath
        }
        insertSublayer(layerDashBorder, at: 0)
    }
}

//MARK: - Enum YZGradientPoint
/// This enum is define all coordinate to draw a gradients on view.
public enum YZGradientPoint {
    case leftRight
    case rightLeft
    case topBottom
    case bottomTop
    case topLeftBottomRight
    case bottomRightTopLeft
    case topRightBottomLeft
    case bottomLeftTopRight
    public var draw: (startPoint: CGPoint, endPoint: CGPoint) {
        switch self {
        case .leftRight:
            return (startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
        case .rightLeft:
            return (startPoint: CGPoint(x: 1, y: 0.5), endPoint: CGPoint(x: 0, y: 0.5))
        case .topBottom:
            return (startPoint: CGPoint(x: 0.5, y: 0), endPoint: CGPoint(x: 0.5, y: 1))
        case .bottomTop:
            return (startPoint: CGPoint(x: 0.5, y: 1), endPoint: CGPoint(x: 0.5, y: 0))
        case .topLeftBottomRight:
            return (startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1))
        case .bottomRightTopLeft:
            return (startPoint: CGPoint(x: 1, y: 1), endPoint: CGPoint(x: 0, y: 0))
        case .topRightBottomLeft:
            return (startPoint: CGPoint(x: 1, y: 0), endPoint: CGPoint(x: 0, y: 1))
        case .bottomLeftTopRight:
            return (startPoint: CGPoint(x: 0, y: 1), endPoint: CGPoint(x: 1, y: 0))
        }
    }
}

/// CALayer extensiton to add CAGradientLayer to any CALayer.
extension CALayer {
    
    /// It will use to add gradient colors using `CAGradientLayer`, with specific parameters.
    /// - Parameters:
    ///   - colors: The collection of colors to add gradeints.
    ///   - gradientPoint: The gradient point to draw gradients.
    public func addGradient(_ colors: [UIColor],
                     gradientPoint: YZGradientPoint) {
        if let subLayers = sublayers, subLayers.isEmpty == false {
            for layer in subLayers {
                if layer is CAGradientLayer {
                    layer.removeFromSuperlayer()
                }
            }
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = gradientPoint.draw.startPoint
        gradientLayer.endPoint = gradientPoint.draw.endPoint
        
        insertSublayer(gradientLayer, at: 0)
    }
    
    /// It will use to add gradient colors using `CAGradientLayer`, with specific parameters.
    /// - Parameters:
    ///   - colors: The collection of colors to add gradeints.
    ///   - gradientPoint: The gradient point to draw gradients.
    ///   - roundingCorners: The rounding corners of UIView. Defaults to **[.allCorners]**.
    ///   - cornerRadii: The corner raddi size. Default to **.zero**.
    public func addGradient(_ colors: [UIColor],
                     gradientPoint: YZGradientPoint,
                     roundingCorners: UIRectCorner = [.allCorners],
                     cornerRadii: CGSize = .zero) {
        if let subLayers = sublayers, subLayers.isEmpty == false {
            for layer in subLayers {
                if layer is CAGradientLayer {
                    layer.removeFromSuperlayer()
                }
            }
        }
        
        let cgPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: roundingCorners, cornerRadii: cornerRadii).cgPath
        let layerRadius = CAShapeLayer()
        layerRadius.path = cgPath

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = gradientPoint.draw.startPoint
        gradientLayer.endPoint = gradientPoint.draw.endPoint
        gradientLayer.mask = layerRadius

        insertSublayer(gradientLayer, at: 0)
    }
}
