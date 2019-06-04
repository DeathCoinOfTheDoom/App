import UIKit

class ColorConstant: NSObject {
    static let White: UIColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
    static let Red: UIColor = UIColor(red:0.91, green:0.45, blue:0.44, alpha:1.0)
    static let RedLight: UIColor = UIColor(red:0.98, green:0.89, blue:0.89, alpha:1.0)
    
    struct Green {
        static let Dark : UIColor = UIColor(red:0.10, green:0.58, blue:0.45, alpha:1.0)
        static let Primary: UIColor = UIColor(red:0.24, green:0.74, blue:0.58, alpha:1.0)
    }
    
    struct Error {
        static let ERROR : UIColor = UIColor(red:0.82, green:0.25, blue:0.25, alpha:1.0)
    }
    
    struct Success {
        static let BASE : UIColor = UIColor(red:0.24, green:0.74, blue:0.58, alpha:1.0)
    }
    
    struct Primary {
        static let LIGHTER : UIColor = UIColor(red:0.48, green:0.53, blue:0.58, alpha:1.0)
        static let LIGHT : UIColor = UIColor(red:0.91, green:0.96, blue:0.98, alpha:1.0)
        static let BASE : UIColor = UIColor(red:0.25, green:0.76, blue:1.0, alpha:1.0)
    }
    
    struct Secondary {
        static let PINK : UIColor = UIColor(red:0.96, green:0.73, blue:0.82, alpha:1.0)
        static let BLUE : UIColor = UIColor(red:0.70, green:0.92, blue:0.99, alpha:1.0)
        static let YELLOW : UIColor = UIColor(red:1.00, green:0.95, blue:0.77, alpha:1.0)
        static let GREEN : UIColor = UIColor(red:0.78, green:0.97, blue:0.89, alpha:1.0)
    }
    
    struct Border {
        static let BASE : UIColor = UIColor(red:0.89, green:0.91, blue:0.92, alpha:1.0)
    }
    
    struct Neutral {
        static let LIGHTER : UIColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
        static let LIGHT : UIColor = UIColor(red:0.0, green:0.0, blue:0.0, alpha:1.0)
        static let DARKEST : UIColor = UIColor(red:0.12, green:0.16, blue:0.20, alpha:1.0)
    }
    
    struct Boxshadow {
        static let BASE : UIColor = UIColor(red:0.77, green:0.77, blue:0.77, alpha:1.0)
    }
}
