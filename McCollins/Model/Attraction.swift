//
//  Attraction.swift
//  McCollins
//
//  Created by Noh Tewolde on 3/31/19.
//  Copyright © 2019 Noh Tewolde. All rights reserved.
//

import UIKit

class Attraction: NSObject {
    var img         : String?
    var title       : String?
    var desc        : String?
    var latitude    : String?
    var longitude   : String?
    var contact     : String?
    var siteLink    : String?
    var timing      : String?
    
    init(newElement: [String:Any]){
        img = newElement["image"] as? String
        title = newElement["title"] as? String
        desc = newElement["description"] as? String
        latitude = newElement["latitude"] as? String
        longitude = newElement["longitude"] as? String
        contact = newElement["contact"] as? String
        siteLink = newElement["sitelink"] as? String
        timing = newElement["timing"] as? String
    }
}
