//
//  Movie.swift
//  MovieX
//
//  Created by Da on 9/7/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation
import ObjectMapper

class Movie: BaseModel {
    var id: Int = 0
    var title = ""
    var posterPath = ""
    var vote: Double = 0.00
    var overview = ""
    var releaseDate = Date()
    var popularity: Int = 0
    var backdropPath = ""
    var character = ""
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["original_title"]
        posterPath <- map["poster_path"]
        vote <- map["vote_average"]
        overview <- map["overview"]
        releaseDate <- map["release_date"]
        popularity <- map["popularity"]
        character <- map["character"]
        backdropPath <- map["backdrop_path"]
    }
}
