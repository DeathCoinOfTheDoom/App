import Foundation
import UIKit

class ProgressBar: UIProgressView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        self.layer.sublayers![1].cornerRadius = 4
        self.subviews[1].clipsToBounds = true
    }
}
