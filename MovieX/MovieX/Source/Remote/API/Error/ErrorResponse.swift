//
//  ErrorResponse.swift
//  MovieX
//
//  Created by Da on 9/7/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation
import ObjectMapper
class ErrorResponse: Mappable {
    
    var message: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        message <- map["status_message"]
    }
}
