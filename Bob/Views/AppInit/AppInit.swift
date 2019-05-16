//
//  AppInit.swift
//  Bob
//
//  Created by Gérome Lacaux on 05/05/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit

class AppInit: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func dispatchView() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if (TokenHelper().getToken(key: "token") == "") {
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ConnectionNVC") as! UINavigationController
            self.present(nextViewController, animated:true, completion:nil)
        }
        else {
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainTBVC") as! UINavigationController
            self.present(nextViewController, animated:true, completion:nil)
        }
    }
}
