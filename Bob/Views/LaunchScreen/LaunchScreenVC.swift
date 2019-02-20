//
//  LaunchScreen.swift
//  Bob
//
//  Created by Gérome Lacaux on 30/01/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit

class LaunchScreenVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
