//
//  PopUpViewController.swift
//  5StarAutoDirect
//
//  Created by Work on 8/1/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

//import UIKit
//
//class PopUpViewController: UIViewController {
//    
//    @IBOutlet weak var signInIndicator: UIView!
//    
//    var users: [User] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
//        signInIndicator.layer.cornerRadius = 10
//        signInIndicator.layer.masksToBounds = true
//        
//        showAnimate()
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    //MARK: Pop up animations
//    func showAnimate() {
//        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
//        self.view.alpha = 0.0
//        UIView.animate(withDuration: 0.25) {
//            self.view.alpha = 1.0
//            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//        }
//    }
//    
//    func removeAnimate() {
//        UIView.animate(withDuration: 0.25, animations: {
//            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
//            self.view.alpha = 0.0;
//        }, completion:{(finished : Bool)  in
//            if (finished)
//            {
//                self.view.removeFromSuperview()
//            }
//        });
//    }
//}
