//
//  AppNavigator.swift
//  MovieX
//
//  Created by Da on 9/12/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation
import UIKit

protocol AppNavigatorType {
    func start()
}

struct AppNavigator: AppNavigatorType {
    private struct Constant {
        static let home = "Home"
        static let library = "Library"
        static let genre = "Genre"
        static let iconHome = "icon-home"
        static let iconGenre = "icon-genre"
        static let iconLibrary = "icon-library"
    }
    unowned let window: UIWindow
    
    func start() {
        // HOME VIEWCONTROLLER
        let homeViewController = HomeViewController.instantiate()
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        let homeNavigator = HomeNavigator(navigationController: homeNavigationController)
        let homeViewModel = HomeViewModel(navigator: homeNavigator, useCase: HomeUseCase())
        homeViewController.bindViewModel(to: homeViewModel)
        homeNavigationController.tabBarItem = UITabBarItem(
            title: Constant.home,
            image: UIImage(named: Constant.iconHome),
            selectedImage: UIImage(named: Constant.iconHome)?.withRenderingMode(.alwaysOriginal))
        
        // GENRE VIEWCONTROLLER
        let genreViewController = GenreViewController.instantiate()
        let genreNavigationController = UINavigationController(rootViewController: genreViewController)
        let genreNavigator = GenreNavigator(navigationController: genreNavigationController)
        let genreViewModel = GenreViewModel(navigator: genreNavigator, useCase: GenreUseCase())
        genreViewController.bindViewModel(to: genreViewModel)
        genreNavigationController.tabBarItem = UITabBarItem(
            title: Constant.home,
            image: UIImage(named: Constant.iconGenre),
            selectedImage: UIImage(named: Constant.iconGenre)?.withRenderingMode(.alwaysOriginal))
        
        // LIBRARY VIEWCONTROLLER
        let libraryViewController = LibraryViewController.instantiate()
        let libraryNavigationController = UINavigationController(rootViewController: libraryViewController)
        let libraryNavigator = LibraryNavigator(navigationController: libraryNavigationController)
        let libraryViewModel = LibraryViewModel(navigator: libraryNavigator, useCase: LibraryUseCase())
        libraryViewController.bindViewModel(to: libraryViewModel)
        libraryNavigationController.tabBarItem = UITabBarItem(
            title: Constant.home,
            image: UIImage(named: Constant.iconLibrary),
            selectedImage: UIImage(named: Constant.iconLibrary)?.withRenderingMode(.alwaysOriginal))
        
        // TABBAR VIEWCONTROLLER
        let tabbarViewController = UITabBarController()
        tabbarViewController.addChildViewController(homeNavigationController)
        tabbarViewController.addChildViewController(genreNavigationController)
        tabbarViewController.addChildViewController(libraryNavigationController)
        tabbarViewController.tabBar.tintColor = .black
        window.rootViewController = tabbarViewController
    }
}
