import Foundation
import UIKit

extension String {
    func heightWithConstrainedWidth(width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 15)
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedStringKey.font: font], context: nil)
        return boundingBox.height
    }
}
