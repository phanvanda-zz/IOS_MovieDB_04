//
//  Credit.swift
//  MovieX
//
//  Created by Da on 9/7/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation
import ObjectMapper

class Credit: BaseModel {
    var id: Int = 0
    var name =  ""
    var profilePath = ""
    var gender: Int = 0
    var knownForDepartment = ""
    var biography = ""
    var placeOfBirth = ""
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        profilePath <- map["profile_path"]
        gender <- map["gender"]
        placeOfBirth <- map["placeOfBirth"]
        knownForDepartment <- map["known_for_department"]
        biography <- map["biography"]
    }
}
