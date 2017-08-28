//
//  UIWindowExtension.swift
//  5StarAutoDirect
//
//  Created by Michael Castillo on 8/25/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
// https://stackoverflow.com/questions/26667009/get-top-most-uiviewcontroller

import UIKit
// FIXME: - This is breaking MVC. future update, utilize protocols to promote good architecture

// implementation : if let topController = UIApplication.topViewController() {}
extension UIApplication {
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
