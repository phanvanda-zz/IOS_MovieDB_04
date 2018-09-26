//
//  MoviesType.swift
//  MovieX
//
//  Created by Da on 9/12/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation
enum MoviesType: Int {
    case nowPlaying, popular, topRated, upComing
    
    var getTitle: String {
        switch self {
        case .nowPlaying:
            return "Now Playing Movies"
        case .upComing:
            return "Popular Movies"
        case .topRated:
            return "Top Rated Movies"
        case .popular:
            return "Up Coming Movies"
        }
    }
    var url: String {
        switch self {
        case .nowPlaying:
            return URLs.apiMovieNowPlaying
        case .upComing:
            return URLs.apiMovieUpcoming
        case .topRated:
            return URLs.apiMovieTopRated
        case .popular:
            return URLs.apiMoviePopular
        }
    }
}

class MoviesRequest: BaseRequest {
    required init(id: Int, page: Int) {
        let body: [String: Any] = [
            "api_key": APIKey.key,
            "language": "en-US",
            "page": page
        ]
        super.init(url: URLs.apiMoviesByGenres + "\(id)" + "/movies", requestType: .get, body: body)
    }
}
