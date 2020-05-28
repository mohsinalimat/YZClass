//
//  YZViewController.swift
//  YZLibraries
//
//  Created by Vipul Patel on 18/05/20.
//

import Foundation
import UIKit

//MARK: - UIWindow Extension(s)
extension UIWindow {
    
    /// It is used to get current visible `UIViewController`.
    public var currentVisibleViewController: UIViewController {
        return UIWindow.getCurrentVisibleVCFor(UIApplication.shared.keyWindow!.rootViewController!)
    }
    
    /// It is used to get current visible `UIViewController` for given `UIViewController`.
    public static func getCurrentVisibleVCFor(_ vc: UIViewController) -> UIViewController {
        switch(vc){
        case is UINavigationController:
            let navigationController = vc as! UINavigationController
            return UIWindow.getCurrentVisibleVCFor(navigationController.visibleViewController!)
        case is UITabBarController:
            let tabBarController = vc as! UITabBarController
            return UIWindow.getCurrentVisibleVCFor(tabBarController.selectedViewController!)
        default:
            if let presentedViewController = vc.presentedViewController {
                if let presentedViewController2 = presentedViewController.presentedViewController {
                    return UIWindow.getCurrentVisibleVCFor(presentedViewController2)
                }
                else{
                    return vc;
                }
            }
            else{
                return vc;
            }
        }
    }
}

//MARK: - UIViewController Extension(s)
extension UIViewController {
    
    /// It is used to get current visible `UIViewController`.
    public var currentVisibleViewController: UIViewController {
        //Check presentedViewController equal nil, if yes then return self
        if presentedViewController == nil {
            return self
        }
        
        //Check presentedViewController equal UINavigationController
        if let navigation = presentedViewController as? UINavigationController {
            if let visibleController = navigation.visibleViewController {
                return visibleController.currentVisibleViewController
            }
        }
        
        //Check presentedViewController equal UITabBarController
        if let tab = presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.currentVisibleViewController
            }
            return tab.currentVisibleViewController
        }
        
        return presentedViewController!.currentVisibleViewController
    }
}

//MARK: - UIApplication Extension(s)
extension UIApplication {
    
    /// It is used to get current visible `UIViewController`.
    public var currentVisibleViewController: UIViewController {
        return keyWindow!.rootViewController!.currentVisibleViewController
    }
}
