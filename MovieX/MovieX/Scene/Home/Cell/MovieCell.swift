//
//  MovieCell.swift
//  MovieX
//
//  Created by Da on 9/25/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import UIKit
import Reusable
import Cosmos

class MovieCell: UICollectionViewCell, NibReusable {
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var starCosmos: CosmosView!
    
    private struct Constant {
        static let ratioStar = 0.5   
    }
    
    func configCell(movie: Movie) {
        let imageUrl = URL(string: URLs.apiPosterImage + movie.posterPath)
        posterImageView.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "image_notFound"))
        titleLabel.text = movie.title
        starCosmos.rating = movie.vote * Constant.ratioStar
    }
}
