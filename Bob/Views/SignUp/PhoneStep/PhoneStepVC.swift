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

class PhoneStepVc: UIInputViewController {
    @IBOutlet weak var phoneInput: FPNTextField!
    @IBAction func phoneSendButton(_ sender: Any) {
        if let phoneValue = phoneInput.getFormattedPhoneNumber(format: .International) {
            LoginService.validation(query: "auth/sms", payload: ["phone_num": phoneValue], header: HeaderBuilderBob.headers){ (phone, e) in
                print("gouac",phone, e)
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
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    override func dismissKeyboard() {
        view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    func setInputPreferences(){
        phoneInput.setFlag(for: .FR)
        phoneInput.setCountries(including: [.FR, .ES, .IT, .BE, .LU, .DE])
    }
}
