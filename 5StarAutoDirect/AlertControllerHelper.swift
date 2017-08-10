//
//  AlertControllerHelper.swift
//  5StarAutoDirect
//
//  Created by Michael Castillo on 8/9/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import Foundation


enum AlertText: String {
    
    case make
    case model
    case budget
    case color
    case other
    
    var title: String? {
        switch self {
        case .make:
            return "Please enter a make"
        case .model:
            return "Please enter a model"
        case .budget:
            return"Please enter a budget"
        case .color:
            return "Please enter a color"
        default:
            return nil
        }
    }
    
    var message: String? {
        switch self {
        case .other:
            return "Would you like to add any other notes before moving on?"
        default:
            return nil
        }
    }
    
}
