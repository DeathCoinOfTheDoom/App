//
//  NameViewController.swift
//  Bob
//
//  Created by Isabelle Melchiori on 30/01/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit

class NameViewController: UIViewController {

    
    @IBOutlet weak var FirstName: Input!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var DestViewController: BirthdayViewController = segue.destination as! BirthdayViewController
        DestViewController.birthdayTitleText = FirstName.text!

    }
}
