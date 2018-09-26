//
//  HomeUseCase.swift
//  MovieX
//
//  Created by Da on 9/12/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeUseCaseType {
    func getMoviesByGenre(id: Int, page: Int) -> Observable<[Movie]>
    func getGenres() -> Observable<[Genre]>
}

struct HomeUseCase: HomeUseCaseType {
    func getGenres() -> Observable<[Genre]> {
        let request = GenresRequest()
        let repository = HomeRepositoryImp(api: APIService.share)
        return repository.getGenres(input: request)
    }
    
    func getMoviesByGenre(id: Int, page: Int) -> Observable<[Movie]> {
        let request = MoviesRequest(id: id, page: page)
        let repository = HomeRepositoryImp(api: APIService.share)
        return repository.getMovies(input: request)
    }
}
