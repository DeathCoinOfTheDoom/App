//
//  KeyboardController.swift
//  Bob
//
//  Created by Gérome Lacaux on 25/04/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import Foundation
import UIKit

class KeyboardController: UIInputViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func dismissKeyboard() {
        view.endEditing(true)
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
}
