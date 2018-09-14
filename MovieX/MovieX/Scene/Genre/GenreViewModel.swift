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

struct GenreViewModel: ViewModelType {
    struct Input {}
    struct Output {}
    
    let navigator: GenreNavigatorType
    let useCase: GenreUseCaseType
    
    func transform(_ input: GenreViewModel.Input) -> GenreViewModel.Output {
        let errortracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        return Output()
    }
}
