//
//  AddCollectionViewCell.swift
//  Bob
//
//  Created by Gérome Lacaux on 30/01/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit

class AddFolderCell: UICollectionViewCell {
    
    @IBOutlet weak var addButton: UIButton!
    
    // Méthode appelée lorsque la vue a été chargée depuis le Storyboard
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.backgroundColor = ColorConstant.Primary.LIGHTEST.cgColor
        addButton.layer.backgroundColor = ColorConstant.Primary.LIGHT.cgColor
        print("width",addButton.frame.width)
        addButton.layer.cornerRadius = addButton.frame.width / 2
        addButton.clipsToBounds = true
    }
    
}
