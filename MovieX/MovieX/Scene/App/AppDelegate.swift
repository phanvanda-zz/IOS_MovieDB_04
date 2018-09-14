//
//  AppDelegate.swift
//  MovieX
//
//  Created by Da on 9/6/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import UIKit
import CoreData
import RxSwift
import RxCocoa
import NSObject_Rx

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        bindViewModel()
        return true
    }
    
    private func bindViewModel() {
        guard let window = window else { return }
        let navigator = AppNavigator(window: window)
        let appUseCase = AppUseCase()
        let appViewModel = AppViewModel(navigator: navigator, useCase: appUseCase)
        let input = AppViewModel.Input(loadTrigger: Driver.just(()))
        let output = appViewModel.transform(input)
        output.toMain.drive().disposed(by: rx.disposeBag)
    }
}
