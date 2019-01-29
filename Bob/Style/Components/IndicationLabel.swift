//
//  IndicationLabel.swift
//  Bob
//
//  Created by Isabelle Melchiori on 29/01/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit

class IndicationLabel: UILabel {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = UIFont(name: Fonts.proximaRegular, size: 16)
        self.textColor = ColorConstant.Neutral.DARKEST
    }

}
