//
//  BusinessAddressDataModel.swift
//  MyUIKitProyect
//
//  Created by Fernando Corral on 6/1/22.
//

import Foundation

public struct BusinessAddressDataModel: Decodable, Hashable {
    
    let street: String?
    
    let country: String?
}
