import Foundation
import UIKit

class TabBar: UITabBar {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.shadowColor = ColorConstant.Boxshadow.BASE.cgColor
        self.layer.shadowOpacity = 0.9
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 8
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 0
        self.clipsToBounds = false
        self.backgroundColor = UIColor.white
        self.shadowImage = UIImage()
        self.backgroundImage = UIImage()
    }
}
