//
//  HomeViewController.swift
//  MovieX
//
//  Created by Da on 9/11/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa
import MBProgressHUD
import NSObject_Rx
import iCarousel
import Then
import SideMenu

class HomeViewController: UIViewController, BindableType {
    var viewModel: HomeViewModel!
    var moviesUpcoming = [Movie]()
    @IBOutlet private weak var carouselView: iCarousel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func bindViewModel() {
        let input = HomeViewModel.Input(
            loadTrigger: Driver.just(())
        )
        let output = viewModel.transform(input)
        output.moviesUpcoming.drive(onNext: { [weak self] value in
            guard let `self` = self else { return }
            self.moviesUpcoming = value
            self.carouselView.reloadData()
        }).disposed(by: rx.disposeBag)
    }
}
extension HomeViewController: iCarouselDataSource, iCarouselDelegate {
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let itemView = UIImageView().then {
            $0.frame = CGRect(x: 0, y: 0, width: carouselView.frame.width * 3/4, height: carouselView.frame.height * 0.9)
            $0.contentMode = .top
        }
        
        let imageContentView = UIImageView().then {
            $0.frame = itemView.bounds
            $0.backgroundColor = .clear
        }
        itemView.addSubview(imageContentView)
        let imageUrl = URL(string: URLs.backdropImage + moviesUpcoming[index].backdropPath)
        imageContentView.sd_setImage(with: imageUrl, placeholderImage: nil)
        return itemView
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return moviesUpcoming.count
    }
}

extension HomeViewController: StoryboardBased {
    static var sceneStoryboard = Storyboards.home
}
