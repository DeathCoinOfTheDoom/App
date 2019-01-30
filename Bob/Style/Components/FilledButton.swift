//
//  FilledButton.swift
//  Bob
//
//  Created by Isabelle Melchiori on 29/01/2019.
//  Copyright © 2019 Bob. All rights reserved.
//


import Foundation
import UIKit

class FilledButton : UIButton {
    required init?(coder aDecoder: NSCoder) {
        let screenScale = UIScreen.main.scale
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 8.0
        self.layer.borderColor = ColorConstant.Primary.DARK.cgColor
        self.layer.borderWidth = 1.5
        self.backgroundColor = ColorConstant.Primary.DARK
        self.tintColor = UIColor.white
        self.titleLabel?.font =  UIFont(name: Fonts.proximaBold, size: 18)
        self.contentEdgeInsets = UIEdgeInsets(top: (screenScale * 8), left: (screenScale * 3), bottom: (screenScale * 8), right: (screenScale * 3))
        
    }
    
    
}

