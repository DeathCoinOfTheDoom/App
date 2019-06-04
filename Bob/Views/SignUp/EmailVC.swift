//
//  EmailVC.swift
//  Bob
//
//  Created by Gérome Lacaux on 29/05/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit

class EmailVC: UIViewController {
    @IBOutlet weak var emailInput: Input!
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BirthdayViewController {
            if var user = user {
                user.attributes.email = emailInput.text!
                destination.user = user
            }
        }
    }
}
