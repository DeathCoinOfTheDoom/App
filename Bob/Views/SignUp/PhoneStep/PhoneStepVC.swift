//
//  stepOneVC.swift
//  Bob
//
//  Created by Victor Lucas on 28/01/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit
import PhoneNumberKit
import FlagPhoneNumber

class PhoneStepVc: UIViewController {
    @IBOutlet weak var phoneInput: FPNTextField!
    @IBAction func phoneSendButton(_ sender: Any) {
        if let phoneValue = phoneInput.text {
             print("phoneValue", phoneValue)
        } else {
            print("empty value")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setInputPreferences()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    func setInputPreferences(){
        phoneInput.setFlag(for: .FR)
        phoneInput.setCountries(including: [.FR, .ES, .IT, .BE, .LU, .DE])
    }
}
