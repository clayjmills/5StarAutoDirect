//
//  FiveStepTableViewController.swift
//  5StarAutoDirect
//
//  Created by Alex Whitlock on 6/19/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import UIKit
import Firebase

class FiveStepTableViewController: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stepsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stepCell", for: indexPath)
        cell.textLabel?.text = stepsArray[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        return cell
    }

    let stepsArray: [String] = ["STEP 1: Decide what you want. Believe it or not – this is the hardest part! Once we’ve nailed down exactly what you’re looking for, we’ll search the entire country to find exactly what you want – and for the best value possible. If you aren’t sure what you want, our professional brokers can make recommendations based on overall value, reliability, miles-per-gallon, and other factors. We will source cars that are 2007 or newer and under 130K in miles.", "STEP 2: Drop a deposit. $100 is all we need to kick off the search and get the ball rolling. In the highly-improbable event that we are unable to find what you want anywhere in the country, we will issue an immediate refund on your deposit. Otherwise, your deposit will be applied toward your purchase. Either way – this is 100% risk free to you!", "STEP 3: Good, better, best. Give us a day or so (usually just a few hours), and we’ll bring you a few comparables to review – each with subtle variations that play a factor in how much you save (ie. mileage, condition, features, year, etc.). If you aren’t immediately thrilled with what you see – no sweat! We’ll adjust the search as needed and keep coming back until you’re in love.", "STEP 4: Go time! Once you’ve selected the vehicle you want, there’s really not going to be much else for you to do for the next few days, except… well… carry on with life. During this time – the following are services / certifications we will be rendered:  5 STAR INSPECTED™ – Your car will be test driven and inspected by an ASE certified mechanic. Any items that need to be fixed to pass safety and emissions will be repaired prior to you ever driving your new car.  5 STAR SERVICED™ – Your new car will receive a service, fresh oil change, and fluid top off. 5 STAR DETAILED™ – Your new car will receive our exclusive detail.", "STEP 5: Delivery! We’ll show up at your doorstep with your dream car, a high five, and a final agreement. Our average signing time is less than 10 minutes. After that, you’re all set to go! We hope this information was helpful. If you still have questions, or if you’re ready to get started, call (801) 802-7827"]
}
