//
//  Tip.swift
//  Bob
//
//  Created by Gérome Lacaux on 11/03/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import Foundation
import UIKit

class Tip: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = ColorConstant.Primary.LIGHT
        self.layer.cornerRadius = 10
        self.tintColor = ColorConstant.Primary.BASE 
    }
}
