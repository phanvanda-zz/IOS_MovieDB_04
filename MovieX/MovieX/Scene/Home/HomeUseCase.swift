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
    func getMovies(listType: MoviesType) -> Observable<[Movie]>
}

struct HomeUseCase: HomeUseCaseType {
    func getMovies(listType: MoviesType) -> Observable<[Movie]> {
        let request = MoviesRequest(listType: listType, page: 1)
        let repository = HomeRepositoryImp(api: APIService.share)
        return repository.getMovies(input: request)
    }
}
