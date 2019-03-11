//
//  AuthCodeTextField.swift
//  Bob
//
//  Created by Gérome Lacaux on 30/01/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit

protocol AuthCodeTextFieldDelegate : UITextFieldDelegate {
    func didPressBackspace(textField : AuthCodeTextField)
}

class AuthCodeTextField: Input {
    
    override func deleteBackward() {
        super.deleteBackward()
        // If conforming to our extension protocol
        if let pinDelegate = self.delegate as? AuthCodeTextFieldDelegate {
            pinDelegate.didPressBackspace(textField: self)
        }
    }
}
