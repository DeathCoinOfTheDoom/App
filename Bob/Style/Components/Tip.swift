import Foundation
import UIKit

class Tip: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = ColorConstant.Primary.LIGHT
        self.layer.cornerRadius = 10
        self.tintColor = ColorConstant.Primary.BASE 
    }
}
