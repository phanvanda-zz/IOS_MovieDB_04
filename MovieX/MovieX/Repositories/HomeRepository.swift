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
    func getGenres(input: GenresRequest) -> Observable<[Genre]>
    func getMovies(input: MoviesRequest) -> Observable<[Movie]>
    func getDetailMovie(input: MovieDetailRequest) -> Observable<Movie>
}

class HomeRepositoryImp: HomeRepository {
    
    private let api: APIService
    
    required init(api: APIService) {
        self.api = api
    }
   
    func getMovies(input: MoviesRequest) -> Observable<[Movie]> {
        return api.request(input: input)
        .map { (reponse: MoviesResponse) -> [Movie] in
            return reponse.movies
        }
    }
    
    func getDetailMovie(input: MovieDetailRequest) -> Observable<Movie> {
        return api.request(input: input)
        .map{ respone -> Movie in
            return respone
        }
    }
    
    func getGenres(input: GenresRequest) -> Observable<[Genre]> {
        return api.request(input: input)
        .map { (response: GenresReponse) -> [Genre] in
            return response.genres
        }
    }
}
