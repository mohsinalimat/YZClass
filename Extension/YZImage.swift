//
//  YZImage.swift
//  YZLibraries
//
//  Created by Vipul Patel on 18/05/20.
//

import UIKit
import ImageIO
import Accelerate

//MARK: - UIImage Extension(s)
extension UIImage {
    
    /// It is used to fixed orientation of given image.
    public var fixedOrientation: UIImage {
        if imageOrientation == .up {
            return self
        }
        
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat.pi)
            break
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2.0)
            break
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: CGFloat.pi / -2.0)
            break
        case .up, .upMirrored:
            break
        @unknown default:
            fatalError("NO MORE IMAGE ORIENTATION.")
        }
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform.translatedBy(x: size.width, y: 0)
            transform.scaledBy(x: -1, y: 1)
            break
        case .leftMirrored, .rightMirrored:
            transform.translatedBy(x: size.height, y: 0)
            transform.scaledBy(x: -1, y: 1)
        case .up, .down, .left, .right:
            break
        @unknown default:
            fatalError("NO MORE IMAGE ORIENTATION.")
        }
        
        let ctx: CGContext = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0, space: self.cgImage!.colorSpace!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        
        ctx.concatenate(transform)
        
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
        default:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            break
        }
        
        return UIImage(cgImage: ctx.makeImage()!)
    }
    
    /// It is used to generate QRCode image from given string
    /// - Parameter string: `String` type value
    /// - Returns: It will return `UIImage` object.
    public static func generateQRCodeFrom(_ string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
    /// It is used to generate square image.
    /// - Returns: It will return `UIImage` object.
    public func getSquareImage() -> UIImage {
        var xCord: CGFloat = 0
        var yCord: CGFloat = 0
        
        let diff = size.height - size.width
        if diff > 0{
            yCord = CGFloat(diff / 2)
        }else{
            xCord = CGFloat((diff * -1) / 2)
        }
        
        let heightWid = min(size.width, size.height)
        let origin =  CGPoint(x: xCord, y: yCord)
        let newSize = CGSize(width: heightWid, height: heightWid)
        if let croppedImg = self.cgImage!.cropping(to: CGRect(origin: origin, size: newSize)) {
            return UIImage(cgImage: croppedImg)
        }
        
        return self
    }
    
    /// It is used to resize image with given parameters.
    /// - Parameters:
    ///   - width: `CGFloat` type value to provide image width.
    ///   - height: `CGFloat` type value to provide image height.
    /// - Returns: It will return `UIImage` object.
    public func resizeImageWith(_ width: CGFloat, height: CGFloat) -> UIImage? {
        let horizontalRatio = width/size.width
        let verticalRatio = height/size.height
        let ratio = max(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// It is used to scales an image to fit within a bounds with a size governed by the passed size. Also keeps the aspect ratio.
    /// - Parameters:
    ///   - newSize: `CGSize` type object.
    ///   - isAspectFill: `Bool` type value to manage image aspect fill or aspect fit.
    /// - Returns: It will return scaled `UIImage` object.
    func scaleTo(_ newSize: CGSize, isAspectFill: Bool = true) -> UIImage {
        var scaledImageRect = CGRect.zero
        let aspectWidth = newSize.width/size.width
        let aspectheight = newSize.height/size.height
        var aspectRatio: CGFloat!
        if isAspectFill {
            aspectRatio = max(aspectWidth, aspectheight)
        }else{
            aspectRatio = min(aspectWidth, aspectheight)
        }
        scaledImageRect.size.width = size.width * aspectRatio;
        scaledImageRect.size.height = size.height * aspectRatio;
        scaledImageRect.origin.x = (newSize.width - scaledImageRect.size.width) / 2.0;
        scaledImageRect.origin.y = (newSize.height - scaledImageRect.size.height) / 2.0;
        UIGraphicsBeginImageContext(newSize)
        draw(in: scaledImageRect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage!
    }
    
    
    /// It is used to reduce image resolution and maintain aspect ratio.
    ///
    /// - Parameter width: Expected width to reduce resolution
    /// - Returns: It will return `UIImage` object.
    func scaleAndManageAspectRatio(_ width: CGFloat) -> UIImage? {
        let resizedImage: UIImage? = nil
        if let cgImage = cgImage {
            let oldWidth = size.width
            let oldHeight = size.height
            if oldHeight < width && oldWidth < width {
                return self
            }
            let scaleFactor = oldWidth > oldHeight ? width/oldWidth : width/oldHeight
            let newHeight = oldHeight * scaleFactor
            let newWidth = oldWidth * scaleFactor;
            var format = vImage_CGImageFormat(bitsPerComponent: 8, bitsPerPixel: 32, colorSpace: nil, bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.first.rawValue),version: 0, decode: nil, renderingIntent: CGColorRenderingIntent.defaultIntent)
            var sourceBuffer = vImage_Buffer()
            defer {
                sourceBuffer.data.deallocate()
            }
            var error = vImageBuffer_InitWithCGImage(&sourceBuffer, &format, nil, cgImage, numericCast(kvImageNoFlags))
            guard error == kvImageNoError else { return resizedImage }
            
            // create a destination buffer
            let destWidth = Int(newWidth)
            let destHeight = Int(newHeight)
            let bytesPerPixel = cgImage.bitsPerPixel/8
            let destBytesPerRow = destWidth * bytesPerPixel
            let destData = UnsafeMutablePointer<UInt8>.allocate(capacity: destHeight * destBytesPerRow)
            defer {
                destData.deallocate()
            }
            var destBuffer = vImage_Buffer(data: destData, height: vImagePixelCount(destHeight), width: vImagePixelCount(destWidth), rowBytes: destBytesPerRow)
            
            // scale the image
            error = vImageScale_ARGB8888(&sourceBuffer, &destBuffer, nil, numericCast(kvImageHighQualityResampling))
            guard error == kvImageNoError else { return nil }
            
            // create a CGImage from vImage_Buffer
            let destCGImage = vImageCreateCGImageFromBuffer(&destBuffer, &format, nil, nil, numericCast(kvImageNoFlags), &error)?.takeRetainedValue()
            guard error == kvImageNoError else { return nil }
            
            // create a UIImage
            return destCGImage.flatMap { (cgImage) -> UIImage? in
                return UIImage(cgImage: cgImage, scale: 0.0, orientation: imageOrientation)
            }
        }else{
            return resizedImage
        }
    }
}
