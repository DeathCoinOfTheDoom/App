//
//  stepOneVC.swift
//  Bob
//
//  Created by Victor Lucas on 28/01/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit
import PhoneNumberKit

class PhoneStepVc: UIViewController {
    let phoneNumberKit = PhoneNumberKit()

    @IBOutlet weak var PhoneInput: Input!
    @IBAction func PhoneSendButton(_ sender: Any) {
        if let PhoneValue = PhoneInput.text {
            do {
                let phoneNumber = try phoneNumberKit.parse(PhoneValue)
                let test = phoneNumberKit.format(phoneNumber, toType: .international)
            }
            catch {
                print("Generic parser error")
            }
        } else {
            print("empty value")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "< Accueil", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    @objc func back(sender: UIBarButtonItem) {
        print("test")
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        _ = navigationController?.popViewController(animated: true)
    }
}
