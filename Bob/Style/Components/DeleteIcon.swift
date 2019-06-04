//
//  DeleteButton.swift
//  Bob
//
//  Created by Isabelle Melchiori on 03/06/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import Foundation
import UIKit

class DeleteIcon : UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 16.0
        self.layer.borderColor = ColorConstant.Red.cgColor
        self.layer.borderWidth = 1.5
        self.backgroundColor = ColorConstant.Red
        self.tintColor = UIColor.white
        self.contentEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    }
}

