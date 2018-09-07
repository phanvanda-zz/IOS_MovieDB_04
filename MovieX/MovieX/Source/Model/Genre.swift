//
//  Genre.swift
//  MovieX
//
//  Created by Da on 9/7/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation
import ObjectMapper

class Genre: BaseModel {
    var id: Int = 0
    var name = ""
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
