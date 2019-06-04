import UIKit

class IndicationLabel: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = UIFont(name: Fonts.poppinsRegular, size: 14)
        self.textColor = ColorConstant.Primary.LIGHTER
    }
}
