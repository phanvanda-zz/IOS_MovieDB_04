//
//  AppViewModel.swift
//  MovieX
//
//  Created by Da on 9/12/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct AppViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    struct Output {
        let toMain: Driver<Void>
    }
    
    let navigator: AppNavigatorType
    let useCase: AppUseCaseType
    
    func transform(_ input: AppViewModel.Input) -> Output {
        let toMain = input.loadTrigger.do(onNext: self.navigator.start)
        return Output(toMain: toMain)
    }
}
