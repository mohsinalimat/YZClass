//
//  YZActivityIndicator.swift
//  YZLibraries
//
//  Created by Vipul Patel on 18/05/20.
//

import UIKit
import QuartzCore

//MARK:- Class YZActivityIndicator
/// It is used to prepare indicator view
public class YZActivityIndicator: UIView {
    
    /// It will provide `Bool` value to check isAnimating or not.
    public var isAnimating : Bool = false
    
    /// It will used to set property to hide indicator view when it is stopped animation.
    public var hidesWhenStopped : Bool = true
    
    lazy private var animationLayer : CALayer = {
        return CALayer()
    }()
    
    /// It is used to initialize `YZActivityIndicator` object using image.
    /// - Parameter image: `UIImage` type object.
    public init(_ image : UIImage) {
        let frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        super.init(frame: frame)
        animationLayer.frame = frame
        animationLayer.contents = image.cgImage
        animationLayer.masksToBounds = true
        layer.addSublayer(animationLayer)
        addAnimations()
        pause(layer: animationLayer)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addRotation() {
        let rotation = CABasicAnimation(keyPath:"transform.rotation.z")
        rotation.duration = 0.75
        rotation.isRemovedOnCompletion = false
        rotation.repeatCount = HUGE
        rotation.fillMode = CAMediaTimingFillMode.forwards
        rotation.fromValue = NSNumber(value: 0.0)
        rotation.toValue = NSNumber(value: 3.14 * 2.0)
        animationLayer.add(rotation, forKey: "rotate")
    }

    fileprivate func addZoomInOut() {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 0.75
        scaleAnimation.repeatCount = HUGE
        scaleAnimation.autoreverses = true
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 0.5
        animationLayer.add(scaleAnimation, forKey: "scale")
    }

    fileprivate func pause(layer: CALayer) {
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
        isAnimating = false
    }
    
    fileprivate func addAnimations() {
        let duration: CFTimeInterval = 0.75
        /*//Scale animation
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.keyTimes = [0, 0.5, 1]
        scaleAnimation.values = [1, 0.6, 1]*/
        //Rotate animation
        let rotateAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotateAnimation.keyTimes = [0, 0.5, 1]//scaleAnimation.keyTimes
        rotateAnimation.values = [0, Double.pi, 2 * Double.pi]
        //Animation
        let animation = CAAnimationGroup()
        animation.animations = [rotateAnimation]//[scaleAnimation, rotateAnimation]
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false
        animationLayer.add(animation, forKey: "animation")
    }
    
    fileprivate func resume(layer: CALayer) {
        let pausedTime : CFTimeInterval = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
        isAnimating = true
    }
    
    /// It is used to start animation.
    public func startAnimating() {
        if isAnimating {
            return
        }
        if hidesWhenStopped {
            isHidden = false
        }
        resume(layer: animationLayer)
    }
    
    /// It is used to stop animation.
    public func stopAnimating() {
        if hidesWhenStopped {
            isHidden = true
        }
        pause(layer: animationLayer)
    }
}
