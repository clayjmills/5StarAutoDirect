//
//  ViewController.swift
//  riqqoColorExtensions
//
//  Created by Alex Whitlock on 7/10/17.
//  Copyright © 2017 Alex Whitlock. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let alertController = UIAlertController(title: "Please connect to the internet to use this feature", message: nil, preferredStyle: .alert)
    let dismissAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
}

extension UIColor {
    static let backgroundGray = UIColor.init(red: 242, green: 242, blue: 242, alpha: 100) // the header is the same color
    static let riiqoBlue = UIColor.init(red: 50, green: 174, blue: 225, alpha: 100)
    static let riiqoRed = UIColor.init(red: 222, green: 77, blue: 79, alpha: 100)
    static let riiqoGreen = UIColor.init(red: 131, green: 206, blue: 69, alpha: 100)
    static let riiqoPurple = UIColor.init(red: 161, green: 145, blue: 220, alpha: 100)
    static let riiqoOrange = UIColor.init(red: 224, green: 161, blue: 70, alpha: 100)
    static let riiqoBrightGreen = UIColor.init(red: 137, green: 218, blue: 107, alpha: 100)
    static let riiqoCloudOrange = UIColor.init(red: 253, green: 200, blue: 29, alpha: 100)
    static let riiqoRepeatOrange = UIColor.init(red: 251, green: 145, blue: 28, alpha: 100)
    static let riiqoContactCardGreen = UIColor.init(red: 45, green: 172, blue: 78, alpha: 100)
    static let riiqoFilePurple = UIColor.init(red: 159, green: 139, blue: 217, alpha: 100)
    static let riiqoPersonGreen = UIColor.init(red: 130, green: 200, blue: 91, alpha: 100)
}
