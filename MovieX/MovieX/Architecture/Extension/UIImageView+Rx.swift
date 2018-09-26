import Foundation
import RxCocoa
import RxSwift
import UIKit
import SDWebImage

extension Reactive where Base: UIImageView {
    var posterPath: Binder<String> {
        return Binder(base) { view, posterPath in
            let imageUrl = URL(string: URLs.apiPosterImage + posterPath)
            view.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "image_notFound"))
        }
    }
    
    var posterPathBlur: Binder<String> {
        return Binder(base) { view, posterPath in
            let imageUrl = URL(string: URLs.apiPosterImage + posterPath)
            view.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "image_notFound"))
            view.addBlurEffect()
        }
    }
}
