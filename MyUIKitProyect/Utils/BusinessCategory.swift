//
//  BusinessCategory.swift
//  MyUIKitProyect
//
//  Created by Fernando Corral on 6/1/22.
//

import UIKit

public enum BusinessCategory: String, Decodable, CaseIterable {
    case shopping = "SHOPPING"
    case food = "FOOD"
    case beauty = "BEAUTY"
    case leisure = "LEISURE"
    case none = ""
    
    
    var iconWhite: String {
        switch self {
        case .shopping:
            return "Cart_white"
        case .food:
            return "Catering_white"
        case .beauty:
            return "Car wash_white"
        case .leisure:
            return "Leisure_white"
        case .none:
            return ""
        }
    }
    
    var iconColor: String {
        switch self {
        case .shopping:
            return "Cart_colour"
        case .food:
            return "Catering_colour"
        case .beauty:
            return "Car wash_colour"
        case .leisure:
            return "Leisure_colour"
        case .none:
            return ""
        }
    }
    
    var color: UIColor {
        switch self {
        case .shopping:
            return UIColor.red
        case .food:
            return UIColor.orange
        case .beauty:
            return UIColor.green
        case .leisure:
            return UIColor.purple
        case .none:
            return UIColor.orange
        }
    }
}
