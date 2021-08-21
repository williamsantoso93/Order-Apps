//
//  Model.swift
//  Order Apps
//
//  Created by William Santoso on 21/08/21.
//

import Foundation

struct DataModel: Codable {
    let title: String
    let price: String
    let addedUserName: String
    let locationName: String
    var qty: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case title
        case price
        case addedUserName = "added_user_name"
        case locationName = "location_name"
    }
}

