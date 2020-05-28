//
//  YZAppConfig.swift
//  YZLibraries
//
//  Created by Vipul Patel on 21/04/20.
//

import UIKit

//MARK: - Class YZAppConfig
public class YZAppConfig: NSObject {
    public static var appDelegate: UIApplicationDelegate {return UIApplication.shared.delegate!}
    public static var navigationBarHeight: CGFloat!
    public static var designWidth: CGFloat!
    public static var designHeight: CGFloat!
    public static let width        = UIScreen.main.bounds.size.width
    public static let height       = UIScreen.main.bounds.size.height
    public static var widthRatio: CGFloat {return width/designWidth}
    public static var heightRatio: CGFloat {return height/designHeight}
    public static var safeAreaInsets: UIEdgeInsets {return appDelegate.window!!.safeAreaInsets}
    public static var heightOfNavigationBar: CGFloat {return safeAreaInsets.top + navigationBarHeight}

    /// It will configure application desired design Width, Height and Navigation Bar Height.
    /// - Parameters:
    ///   - designWidth: CGFloat type value to configure your application design width.
    ///   - designHeight: CGFloat type value to configure your application designheight.
    ///   - navigationBarHeight: CGFloat type value to configure your application design navigation bar height. Default value is **44**.
    public static func initialise(_ designWidth: CGFloat, designHeight: CGFloat, navigationBarHeight: CGFloat = 44) {
        YZAppConfig.designWidth = designWidth
        YZAppConfig.designHeight = designHeight
        YZAppConfig.navigationBarHeight =  navigationBarHeight
    }
}
