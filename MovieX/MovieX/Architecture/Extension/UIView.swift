//
//  UIView.swift
//  MovieX
//
//  Created by Da on 9/13/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation
import UIKit

class GenreView: UIView {
    var text = ""
    var widthBorder: CGFloat = 1.0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        self.text = title
        self.setupUI()
    }
    
    func setupUI() {
        clipsToBounds = true
        layer.borderWidth = widthBorder
        layer.cornerRadius = 16
    }
}

extension UIView {
    func addTimeView(frame: CGRect,time: Date) {
        let icon = UIImageView(frame: CGRect(
            x: frame.minX + 4,
            y: frame.minY,
            width: 20,
            height: frame.height))
        icon.image = #imageLiteral(resourceName: "icon-time")
        let view = UILabel(frame: CGRect(
            x: icon.frame.maxX + 8,
            y: frame.minY,
            width: frame.width - 60,
            height: frame.height))
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.masksToBounds = true
        view.layer.cornerRadius  = 10
        view.textAlignment = .center
        view.alpha = 1
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        view.text = formatter.string(from: time)
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(icon)
        self.addSubview(view)
    }
    
    func addBonusView(titles: String...) {
        let firstXView: CGFloat = 8
        let width = (self.frame.width - 12 * 4) / 3
        let height: CGFloat = 24
        for index in 0..<3 {
            let view = UIView(frame: CGRect(
                x: firstXView + CGFloat(index) * (firstXView + width),
                y: self.frame.maxY - height - 8,
                width: width,
                height: height)
            )
            let titleLbl = UILabel(frame: view.frame)
            titleLbl.text = titles[index]
            titleLbl.textAlignment = .center
            titleLbl.textColor = UIColor.white
            titleLbl.font = UIFont.systemFont(ofSize: 14)
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.white.cgColor
            view.layer.masksToBounds = true
            view.layer.cornerRadius  = 10
            view.alpha = 1
            self.addSubview(titleLbl)
            self.addSubview(view)
        }
    }
}
