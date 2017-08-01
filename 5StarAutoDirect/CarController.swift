//
//  CarController.swift
//  5StarAutoDirect
//
//  Created by Alex Whitlock on 6/14/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import Foundation

class CarController {
    static let shared = CarController()
    
    func createCar(make: String, model: String, budget: String, color: String, other: String) {
        let car = Car(make: make, model: model, budget: budget, color: color, otherAttributes: other)
    }
}
