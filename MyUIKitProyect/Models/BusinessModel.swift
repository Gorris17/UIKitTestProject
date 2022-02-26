//
//  BusinessModel.swift
//  MyUIKitProyect
//
//  Created by Fernando Corral on 7/1/22.
//

import UIKit
import CoreLocation

public struct BusinessModel: Decodable, Hashable {
    
    public let category: BusinessCategory?
    
    public let name: String?
    
    public let description: String?
    
    public let address: String?
    
    public let latitude: Double?
    
    public let longitude: Double?
    
    public var distance: Double
    
    public let logo: String?
    
    
    public init(businessData: BusinessDataModel) {
        
        self.name = businessData.name
        self.description = businessData.description
        self.latitude = businessData.latitude
        self.longitude = businessData.longitude
        self.logo = businessData.logo?.url
        self.distance = -1
        
        if let category = businessData.category {
            switch category {
            case BusinessCategory.food.rawValue:
                self.category = .food
            case BusinessCategory.shopping.rawValue:
                self.category = .shopping
            case BusinessCategory.leisure.rawValue:
                self.category = .leisure
            case BusinessCategory.beauty.rawValue:
                self.category = .beauty
            default:
                self.category = BusinessCategory.none
            }
        } else {
            self.category = BusinessCategory.none
        }
        
        if let street = businessData.address?.street, let country = businessData.address?.country {
            self.address = street + "," + country
        } else {
            self.address = nil
        }
    
    }
}
