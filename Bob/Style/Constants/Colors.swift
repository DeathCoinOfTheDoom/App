//
//  Colors.swift
//  Bob
//
//  Created by Isabelle Melchiori on 29/01/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit

class ColorConstant: NSObject {
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
    
    struct Border {
        static let LIGHT : UIColor = UIColor(red:0.48, green:0.53, blue:0.58, alpha:1.0)
        static let BASE : UIColor = UIColor(red:0.89, green:0.91, blue:0.92, alpha:1.0)
    }
    
    struct Neutral {
        static let LIGHTER : UIColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
        static let LIGHT : UIColor = UIColor(red:0.0, green:0.0, blue:0.0, alpha:1.0)
        static let DARKEST : UIColor = UIColor(red:0.12, green:0.16, blue:0.20, alpha:1.0)
    }
}
