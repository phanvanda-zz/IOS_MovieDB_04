//
//  MovieDetailRequest.swift
//  MovieX
//
//  Created by Da on 9/18/18.
//  Copyright © 2018 Demo. All rights reserved.
//
import Foundation

class MovieDetailRequest: BaseRequest {
    required init(movieId id: Int) {
        let body: [String: Any]  = [
            "api_key": APIKey.key,
            "language": "en-US"
        ]
        let url = URLs.APIMovieDetailURL + "\(id)"
        super.init(url: url, requestType: .get, body: body)
    }
}
