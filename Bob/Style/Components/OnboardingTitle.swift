import Foundation
import UIKit

class OnboardingLabel: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = UIFont(name: Fonts.poppinsSemiBold, size: 18)
        self.textColor = ColorConstant.Neutral.DARKEST
    }
}

