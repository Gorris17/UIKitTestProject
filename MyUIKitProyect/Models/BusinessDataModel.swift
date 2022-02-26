//
//  BusinessDataModel.swift
//  MyUIKitProyect
//
//  Created by Fernando Corral on 6/1/22.
//

import Foundation

public struct BusinessDataModel: Decodable, Hashable {
    
    public let category: String?
    
    public let name: String?
    
    public let description: String?
    
    public let address: BusinessAddressDataModel?
    
    public let latitude: Double?
    
    public let longitude: Double?
    
    public let logo: BusinessLogoImageModel?
}
