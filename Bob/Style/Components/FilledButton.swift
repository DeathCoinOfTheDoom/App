import Foundation
import UIKit

class FilledButton : UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 10.0
        self.layer.borderColor = ColorConstant.Primary.BASE.cgColor
        self.layer.borderWidth = 1.5
        self.backgroundColor = ColorConstant.Primary.BASE
        self.tintColor = UIColor.white
        self.titleLabel?.font =  UIFont(name: Fonts.poppinsBold, size: 18)
        self.contentEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}
