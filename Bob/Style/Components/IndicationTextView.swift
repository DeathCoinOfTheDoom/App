//
//  IndicationTextView.swift
//  Bob
//
//  Created by Isabelle Melchiori on 02/04/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import Foundation

//
//  IndicationLabel.swift
//  Bob
//
//  Created by Isabelle Melchiori on 29/01/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit

class IndicationTextView: UITextView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = UIFont(name: Fonts.poppinsRegular, size: 14)
        self.textColor = ColorConstant.Neutral.DARKEST
    }
}
