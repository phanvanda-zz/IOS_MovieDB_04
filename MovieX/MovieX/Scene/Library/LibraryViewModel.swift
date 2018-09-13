//
//  LibraryViewModel.swift
//  MovieX
//
//  Created by Da on 9/12/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

struct LibraryViewModel: ViewModelType {
    struct Input {}
    struct Output {}
    
    let navigator: LibraryNavigatorType
    let useCase: LibraryUseCaseType
    
    func transform(_ input: LibraryViewModel.Input) -> LibraryViewModel.Output {
        let errortracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        return Output()
    }
}
