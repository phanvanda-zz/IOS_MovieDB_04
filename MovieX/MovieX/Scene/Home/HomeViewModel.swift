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

struct HomeViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    struct Output {
        let moviesUpcoming: Driver<[Movie]>
    }
    
    let navigator: HomeNavigatorType
    let useCase: HomeUseCaseType
    
    
    func transform(_ input: HomeViewModel.Input) -> HomeViewModel.Output {
        let errortracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        let moviesUpcoming = input.loadTrigger
            .flatMapLatest { _ in
                return self.useCase.getMovies(listType: .nowPlaying)
                    .trackError(errortracker)
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
        }
        
        return Output(
            moviesUpcoming: moviesUpcoming
        )
    }
}
