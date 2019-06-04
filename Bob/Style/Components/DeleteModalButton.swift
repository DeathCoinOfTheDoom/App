import Foundation
import UIKit

class DeleteModalButton : UIButton {
    let screenScale = UIScreen.main.scale
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 8.0
        self.layer.borderColor = ColorConstant.Red.cgColor
        self.layer.borderWidth = 1.5
         self.backgroundColor = ColorConstant.Red
        self.tintColor = ColorConstant.White
        self.titleLabel?.font =  UIFont(name: Fonts.poppinsBold, size: 18)
        self.contentEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}
