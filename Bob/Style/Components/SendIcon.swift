import Foundation
import UIKit

class SendIcon : UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 16.0
        self.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 4)
        self.layer.borderColor = UIColor(red:0.70, green:0.92, blue:0.99, alpha:1.0).cgColor
        self.layer.borderWidth = 1.5
        self.backgroundColor = UIColor(red:0.70, green:0.92, blue:0.99, alpha:1.0)
        self.tintColor = UIColor.white
        self.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 4, right: 4)
    }
}
