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

class PhoneStepVc: KeyboardController {
    @IBOutlet weak var phoneInput: FPNTextField!
    @IBAction func phoneSendButton(_ sender: Any) {
        if let phoneValue = phoneInput.getFormattedPhoneNumber(format: .International) {
            self.view.endEditing(true)
            LoginService.validation(query: "auth/sms", payload: ["phone_num": phoneValue], header: HeaderBuilderBob.headers, phone: phoneValue){ (code, e) in
                if e != nil {
                    print("error", e!)
                }
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthCodeVC") as! AuthCodeVC
                nextVC.phoneNumber = phoneValue
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
