//
//  UIWindowExtension.swift
//  5StarAutoDirect
//
//  Created by Michael Castillo on 8/25/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
// https://stackoverflow.com/questions/26667009/get-top-most-uiviewcontroller

import Foundation

extension UIWindow {
    
    
    func visibleViewController() -> UIViewController? {
        if let rootViewController: UIViewController  = self.rootViewController {
            return UIWindow.getVisibleViewControllerFrom(rootViewController)
        }
        return nil
    }
    
    class func getVisibleViewControllerFrom(vc:UIViewController) -> UIViewController {
        
        if vc.isKindOfClass(UINavigationController.self) {
            
            let navigationController = vc as UINavigationController
            return UIWindow.getVisibleViewControllerFrom( navigationController.visibleViewController)
            
        } else if vc.isKindOfClass(UITabBarController.self) {
            
            let tabBarController = vc as UITabBarController
            return UIWindow.getVisibleViewControllerFrom(tabBarController.selectedViewController!)
            
        } else {
            
            if let presentedViewController = vc.presentedViewController {
                
                return UIWindow.getVisibleViewControllerFrom(presentedViewController!)
                
            } else {
                
                return vc;
            }
        }
}
