//
//  EmptyButton.swift
//  Bob
//
//  Created by Isabelle Melchiori on 29/01/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import Foundation
import UIKit

class OutlinedButton : UIButton {
    required init?(coder aDecoder: NSCoder) {
        let screenScale = UIScreen.main.scale
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 8.0
        self.layer.borderColor = ColorConstant.Primary.DARK.cgColor
        self.layer.borderWidth = 1.5
        self.tintColor = ColorConstant.Primary.DARK
        self.titleLabel?.font =  UIFont(name: Fonts.proximaBold, size: 18)
        self.contentEdgeInsets = UIEdgeInsets(top: (screenScale * 5), left: 0, bottom: (screenScale * 5), right: 0)
        
    }
    
    
}
