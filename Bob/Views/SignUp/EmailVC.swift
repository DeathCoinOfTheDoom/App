//
//  EmailVC.swift
//  Bob
//
//  Created by Gérome Lacaux on 29/05/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit

class EmailVC: UIViewController {
    var user: User?
    
    @IBOutlet weak var emailInput: Input!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BirthdayViewController {
            if var user = user {
                user.attributes.email = emailInput.text!
                print("user----", user)
                destination.user = user
            }
        }
    }

}
