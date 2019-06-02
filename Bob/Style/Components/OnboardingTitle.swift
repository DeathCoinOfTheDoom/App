//
//  OnboardingLabel.swift
//  Bob
//
//  Created by Isabelle Melchiori on 29/01/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import Foundation
import UIKit

class OnboardingLabel: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = UIFont(name: Fonts.poppinsSemiBold, size: 18)
        self.textColor = ColorConstant.Neutral.DARKEST
    }
}

