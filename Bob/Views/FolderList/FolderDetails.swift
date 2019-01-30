//
//  FolderDetails.swift
//  Bob
//
//  Created by Victor Lucas on 28/01/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit

class FolderDetails: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    var folderTitle:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = folderTitle
    }
}
