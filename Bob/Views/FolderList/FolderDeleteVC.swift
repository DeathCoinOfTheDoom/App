//
//  FolderDeleteVC.swift
//  Bob
//
//  Created by Isabelle Melchiori on 03/06/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit

class DeleteFolderVC: UIViewController {
    
    @IBAction func CancelButton(_ sender: Any) {
    }
    
    @IBAction func deleteButton(_ sender: Any) {
    }
    @IBOutlet weak var ModalIndicationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
        ModalIndicationLabel.font = UIFont(name: Fonts.poppinsSemiBold, size: 18)
        ModalIndicationLabel.textColor = ColorConstant.White
    }
    
}

