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
// broker tv, car detail, messageconvo collection, user tvc, userinfo tvc
    func showNotificationBanner() {
        let announcement = Announcement(title: "New Message Received", subtitle: "Click here to go to messages", image: nil, action: nil)
        if let topController = UIApplication.topViewController(){
            Whisper.show(shout: announcement, to: topController)
        }
    }
}

protocol currentView {
    var currentView: UIView { get }
}
