//
//  HomeRepository.swift
//  MovieX
//
//  Created by Da on 9/12/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift

protocol HomeRepository {
    func getMovies(input: MoviesRequest) -> Observable<[Movie]>
}

class HomeRepositoryImp: HomeRepository {
    private let api: APIService!
    
    required init(api: APIService) {
        self.api = api
    }
   
    func getMovies(input: MoviesRequest) -> Observable<[Movie]> {
        return api.request(input: input).map {
            (reponse: MoviesResponse) -> [Movie] in
            return reponse.movies
        }
    }
}
