//
//  HomeViewModel.swift
//  MovieX
//
//  Created by Da on 9/12/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

struct HomeViewModel: ViewModelType {
    struct Input {
        let loadGenreTrigger: Driver<Void>
        let loadMovieTrigger: Driver<Int>
        let loadPageTrigger: Driver<Void>
        let clickLeftButtonTrigger: Driver<Void>
    }
    struct Output {
        let genres: Driver<[Genre]>
        let movies: Driver<[Movie]>
        let clickedLeftButton: Driver<Void>
        let moviesDriver: Driver<Void>
        let moviesPageDriver: Driver<Void>
    }
    
    let navigator: HomeNavigatorType
    let useCase: HomeUseCaseType
    
    func transform(_ input: HomeViewModel.Input) -> HomeViewModel.Output {
        let errortracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        let moviesOriginSubject = BehaviorSubject(value: [Movie]())
        var idCurrent = 0
        var pageCurrent = 1
        
        let genres = input.loadGenreTrigger
            .flatMapLatest { _ in
                return self.useCase.getGenres()
                    .trackError(errortracker)
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
        }
        
        let moviesDriver = input.loadMovieTrigger
            .do(onNext: { id in
                idCurrent = id
            })
            .flatMapLatest { id in
                return self.useCase.getMoviesByGenre(id: id, page: 1)
                    .trackError(errortracker)
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
            }
            .do(onNext: { movies in
                moviesOriginSubject.onNext(movies)
            })
            .mapToVoid()
        
        let moviesPageDriver = input.loadPageTrigger
            .do(onNext: { page in
                pageCurrent += 1
            })
            .flatMapLatest{ page  in
                return self.useCase.getMoviesByGenre(id: idCurrent, page: pageCurrent)
                    .trackError(errortracker)
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
            }
            .do(onNext: { movies in
                try? moviesOriginSubject.onNext(moviesOriginSubject.value() + movies)
            })
            .mapToVoid()
        
        let clickedLeftButton = input.clickLeftButtonTrigger
        
        return Output(
            genres: genres,
            movies: moviesOriginSubject.asDriverOnErrorJustComplete(),
            clickedLeftButton: clickedLeftButton,
            moviesDriver: moviesDriver,
            moviesPageDriver: moviesPageDriver
        )
    }
}
