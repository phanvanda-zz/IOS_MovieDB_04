//
//  UIImageView.swift
//  MovieX
//
//  Created by Da on 9/13/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView
{
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.95
        self.addSubview(blurEffectView)
    }
}
