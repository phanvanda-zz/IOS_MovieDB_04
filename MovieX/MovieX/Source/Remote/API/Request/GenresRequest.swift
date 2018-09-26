//
//  GenresRequest.swift
//  MovieX
//
//  Created by Da on 9/20/18.
//  Copyright © 2018 Demo. All rights reserved.
//

class GenresRequest: BaseRequest {
    required init() {
        let body: [String: Any] = [
            "api_key": APIKey.key,
            "language": "en-US"
        ]
        super.init(url: URLs.apiGenresUrl, requestType: .get, body: body)
    }
}
