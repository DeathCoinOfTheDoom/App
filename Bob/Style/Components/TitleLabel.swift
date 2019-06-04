import Foundation
import UIKit

class TitleLabel: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = UIFont(name: Fonts.poppinsBold, size: 22)
        self.textColor = ColorConstant.Neutral.DARKEST
    }
}
