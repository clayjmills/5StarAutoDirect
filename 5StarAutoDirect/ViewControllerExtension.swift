//
//  NotificationController.swift
//  5StarAutoDirect
//
//  Created by Michael Castillo on 8/24/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import UIKit
import Whisper

extension UIViewController {
    
    func showNotificationBanner() {
        
        let currentUser = UserController.shared.currentUser
        print("button tapped")
        let announcement = Announcement(title: "Message Received", subtitle: "Please check your inbox", image: nil, action: nil)
        if let topController = UIApplication.topViewController() {

            Whisper.show(shout: announcement, to: topController)
        }
    }
}

