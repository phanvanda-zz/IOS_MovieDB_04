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
import Cosmos

class HomeViewController: UIViewController, BindableType {
    private struct Constant {
        static let ratioWidthCarouse: CGFloat = 0.9
        static let ratioHeightCarouse: CGFloat = 1
        static let spaceWidthCarouse: CGFloat = 16
        static let spaceHeightCarouse: CGFloat = 0
        static let heightViewBackground: CGFloat = 60
        static let heightStar: CGFloat = 20
        static let spaceStar: CGFloat = 4
        static let labelHeight: CGFloat = 20
        static let imageNotFoud = #imageLiteral(resourceName: "image_notFound")
        static let timeScroll = 1.0    
        static let timeAutoScroll = 3.0
        static let alphaViewCarusel: CGFloat = 1
        static let alphaViewBackGroundCarusel: CGFloat = 0.95
        static let ratioStar: Double = 1 / 2
        static let spaceCell: CGFloat = 20
        static let ratioHeight: CGFloat = 1 / 3
        static let ratioWidth: CGFloat = 1 / 3
    }
    
    fileprivate var timer: Timer?
    var viewModel: HomeViewModel!
    var movies = [Movie]()
    var moviesSubject = PublishSubject<Int>()
    var pageSubject = PublishSubject<Void>()
    var leftBarButtonItem = UIBarButtonItem()
    
    @IBOutlet private weak var carouselView: iCarousel!
    @IBOutlet private weak var imageBackground: UIImageView!
    @IBOutlet private weak var genresCollectionView: UICollectionView!
    @IBOutlet private weak var movieCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configGenre()
    }
    
    private func configGenre() {
        genresCollectionView.do {
            $0.register(cellType: GenreCell.self)
            $0.delegate = self
        }
        movieCollectionView.do {
            $0.register(cellType: MovieCell.self)
            $0.delegate = self
        }
    }
    
    private func setupUI() {
        imageBackground.addBlurEffect()
        startTimer()
        carouselView.type = .rotary
        leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "icon-left"), style: .done, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.title = titleNavigation.home
    }
    
    func bindViewModel() {
        let input = HomeViewModel.Input(
            loadGenreTrigger: Driver.just(()),
            loadMovieTrigger: moviesSubject.asDriverOnErrorJustComplete(),
            loadPageTrigger: pageSubject.asDriverOnErrorJustComplete(),
            clickLeftButtonTrigger: leftBarButtonItem.rx.tap.asDriver()
        )
        
        let output = viewModel.transform(input)
        output.genres
            .drive(genresCollectionView.rx.items) { collectionView, index, element in
                let indexPath = IndexPath(row: index, section: 0)
                let cell: GenreCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.configCell(genre: element)
                return cell
            }
            .disposed(by: rx.disposeBag)
        
        output.moviesDriver
            .drive()
            .disposed(by: rx.disposeBag)
        output.moviesPageDriver
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.movies
            .do(onNext: { movies in
                self.movies = movies
                self.carouselView.reloadData()
            })
            .drive(movieCollectionView.rx.items) { collectionView, index, element in
                let indexPath = IndexPath(row: index, section: 0)
                let cell: MovieCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.configCell(movie: element)
                return cell
            }
            .disposed(by: rx.disposeBag)
        
        output.clickedLeftButton
            .drive(onNext: { _ in
                self.movieCollectionView.isHidden = !self.movieCollectionView.isHidden
            })
            .disposed(by: rx.disposeBag)
    }
}

extension HomeViewController: iCarouselDataSource, iCarouselDelegate {
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: Constant.timeAutoScroll, target: self,
                                     selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    private func pauseTimer() {
        timer?.invalidate()
    }
    
    func carouselWillBeginDragging(_ carousel: iCarousel) {
        pauseTimer()
    }
    
    @objc private func autoScroll() {
        carouselView.scrollToItem(at: carouselView.currentItemIndex + 1, duration: Constant.timeScroll)
//         carouselView.scrollToItem(at: carouselView.currentItemIndex + 1, duration: 1 / 2)
    }
    
    func carouselDidScroll(_ carousel: iCarousel) {
        let index = carousel.currentItemIndex
        if index >= 0 {
            guard let url = URL(string: URLs.apiPosterImage + movies[index].posterPath) else { return }
            self.imageBackground.sd_setImage(with: url, completed: nil)
        }
        if carousel.currentItemIndex == movies.count - 1 && movies.count > 0 {
            pageSubject.onNext(())
        }
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let itemView = UIImageView().then {
            $0.frame = CGRect(x: 16,
                              y: 0,
                              width: carouselView.frame.width * Constant.ratioWidthCarouse,
                              height: carouselView.frame.height * Constant.ratioHeightCarouse)
            $0.contentMode = .scaleAspectFit
            $0.alpha = Constant.alphaViewCarusel
        }
        
        let imageContentView = UIImageView().then {
            $0.frame = CGRect(x: itemView.bounds.minX,
                              y: itemView.bounds.minY,
                              width: itemView.bounds.width - Constant.spaceWidthCarouse,
                              height: itemView.bounds.height - Constant.spaceHeightCarouse)
            $0.backgroundColor = .clear
        }
        
        let viewBackground = UIView().then {
            $0.frame = CGRect(x: 0,
                              y: itemView.bounds.height - Constant.heightViewBackground,
                              width: imageContentView.bounds.width,
                              height: Constant.heightViewBackground)
            $0.backgroundColor = UIColor.lightGray
            $0.alpha = 0.8
        }
        
        let starCosmos = CosmosView(
            frame: CGRect(x: Constant.spaceStar,
                          y: itemView.bounds.height - Constant.heightViewBackground + Constant.spaceStar,
                          width: imageContentView.frame.width / 2,
                          height: Constant.heightStar)
        )
        
        let movie = movies[index]
        starCosmos.settings.starSize = Double(Constant.heightStar)
        starCosmos.settings.emptyBorderColor = .white
        starCosmos.settings.emptyColor = .white
        starCosmos.settings.fillMode = .full
        
        itemView.addSubview(imageContentView)
        itemView.addSubview(viewBackground)
        itemView.addSubview(starCosmos)
        
        itemView.addTimeView(frame: CGRect(
            x: starCosmos.frame.maxX,
            y: starCosmos.frame.minY,
            width: itemView.frame.width - starCosmos.frame.maxX,
            height: starCosmos.frame.height),
                             time: movie.releaseDate)
        
        itemView.addBonusView(titles: String(movie.popularity), String(movie.voteCount), String(movie.vote))
        let imageUrl = URL(string: URLs.apiPosterImage + movie.posterPath)
        imageContentView.sd_setImage(with: imageUrl, placeholderImage: Constant.imageNotFoud)
        starCosmos.rating = movie.vote * Constant.ratioStar
        return itemView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 1.1
        }
        return value
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return movies.count
    }
}

extension HomeViewController: StoryboardBased {
    static var sceneStoryboard = Storyboards.home
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.genresCollectionView {
            guard let cell =  collectionView.cellForItem(at: indexPath) as? GenreCell else {
                return
            }
            self.moviesSubject.onNext(cell.id)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ( collectionView.frame.width - Constant.spaceCell ) * Constant.ratioWidth
        if collectionView == self.movieCollectionView {
            let height = ( collectionView.frame.height - Constant.spaceCell ) * Constant.ratioHeight
            return CGSize(width: width,
                          height: height)
        }
        return CGSize(width:width,
                      height: self.genresCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == self.movieCollectionView {
            if indexPath.row == movies.count - 1 {
                let lastElement = movies.count - 1
                print(movies.count)
                print(indexPath.row)
                if indexPath.row == lastElement {
                    self.pageSubject.onNext(())
                }
            }
        }
    }
}
