//
//  HomeReponse.swift
//  MovieX
//
//  Created by Da on 9/12/18.
//  Copyright © 2018 Demo. All rights reserved.
//
import Foundation
import ObjectMapper

class MoviesResponse: BaseModel {
    var movies = [Movie]()
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        movies <- map["results"]
    }
}
