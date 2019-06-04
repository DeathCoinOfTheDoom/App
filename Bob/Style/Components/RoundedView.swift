import Foundation
import UIKit

extension UIView {
    func rounded() {
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
}
