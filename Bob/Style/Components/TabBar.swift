//
//  InputLabel.swift
//  Bob
//
//  Created by Isabelle Melchiori on 17/05/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import Foundation
import UIKit

class TabBar: UITabBar {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
//        self.layer.shadowOffset = CGSize(width: 0, height: 5);
//        self.layer.shadowRadius = 8;
//        self.layer.shadowColor = ColorConstant.Primary.BASE.cgColor
//        self.layer.shadowOpacity = 0.3;
        
        
//        self.layer.shadowOffset = CGSize(width: 2, height: 2)
//        self.layer.shadowRadius = 15;
//        self.layer.shadowColor = ColorConstant.Boxshadow.BASE.cgColor
//        self.layer.shadowOpacity = 1;

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
