import Foundation
import UIKit

class OutlinedButton : UIButton {
    let screenScale = UIScreen.main.scale
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 8.0
        self.layer.borderColor = ColorConstant.Primary.BASE.cgColor
        self.layer.borderWidth = 1.5
        self.tintColor = ColorConstant.Primary.BASE
        self.titleLabel?.font =  UIFont(name: Fonts.poppinsBold, size: 18)
        self.contentEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}
