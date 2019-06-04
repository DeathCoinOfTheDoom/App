import Foundation
import UIKit

class InputLabel: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = UIFont(name: Fonts.poppinsSemiBold, size: 12)
        self.textColor = ColorConstant.Primary.LIGHTER
    }
}
