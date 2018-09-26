//
//  GenresReponse.swift
//  MovieX
//
//  Created by Da on 9/20/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation
import ObjectMapper

class GenresReponse: BaseModel {
    var genres = [Genre]()
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        genres <- map["genres"]
    }
}
