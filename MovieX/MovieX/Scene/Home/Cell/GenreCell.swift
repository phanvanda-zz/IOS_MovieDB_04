//
//  GenreCell.swift
//  MovieX
//
//  Created by Da on 9/20/18.
//  Copyright © 2018 Demo. All rights reserved.
//®

import UIKit
import Reusable

class GenreCell: UICollectionViewCell, NibReusable {
    @IBOutlet private weak var titleLabel: UILabel!
    
    var id = 0

//    override var isHighlighted: Bool {
//        didSet {
//            titleLabel.textColor = isHighlighted || isSelected ? .black : .darkGray
//        }
//    }
    override var isSelected: Bool {
        didSet {
            titleLabel.textColor = isHighlighted || isSelected ? .black : .darkGray
        }
    }
    
    func configCell(genre: Genre) {
        self.isSelected = false
        self.id = genre.id
        titleLabel.text = genre.name
    }
}
