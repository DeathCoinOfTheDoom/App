//
//  Colors.swift
//  Bob
//
//  Created by Isabelle Melchiori on 29/01/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit

class ColorConstant: NSObject {
    
    struct Primary {
        static let BASE : UIColor = UIColor(red:0.37, green:0.82, blue:0.98, alpha:1.0)
        static let DARK : UIColor = UIColor(red:0.17, green:0.69, blue:0.93, alpha:1.0)
        static let DARKER : UIColor = UIColor(red:0.07, green:0.50, blue:0.75, alpha:1.0)
        static let DARKEST : UIColor = UIColor(red:0.01, green:0.33, blue:0.53, alpha:1.0)
        static let LIGHT : UIColor = UIColor(red:0.51, green:0.87, blue:0.99, alpha:1.0)
        static let LIGHTER : UIColor = UIColor(red:0.70, green:0.93, blue:1.00, alpha:1.0)
        static let LIGHTEST : UIColor = UIColor(red:0.89, green:0.97, blue:1.00, alpha:1.0)
    }
    
    struct Neutral {
        
        static let LIGHT : UIColor = UIColor(red:0.80, green:0.82, blue:0.85, alpha:1.0)
        static let DARKEST : UIColor = UIColor(red:0.12, green:0.16, blue:0.20, alpha:1.0)
    }
    
}
