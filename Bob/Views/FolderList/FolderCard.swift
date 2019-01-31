//
//  FolderCard.swift
//  Bob
//
//  Created by Gérome Lacaux on 30/01/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit

class FolderCard: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0).cgColor
        self.layer.cornerRadius = 9.0
        self.layer.shadowRadius = 2.0
        self.layer.shadowColor = UIColor(red:0.82, green:0.82, blue:0.82, alpha:1.0).cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
    
}
