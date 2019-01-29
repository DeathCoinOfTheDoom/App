//
//  MyTextField.swift
//  Bob
//
//  Created by Gérome Lacaux on 29/01/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit

protocol PinTexFieldDelegate : UITextFieldDelegate {
    func didPressBackspace(textField : PinTextField)
}

class PinTextField: UITextField {
    
    override func deleteBackward() {
        super.deleteBackward()
        // If conforming to our extension protocol
        if let pinDelegate = self.delegate as? PinTexFieldDelegate {
            pinDelegate.didPressBackspace(textField: self)
        }
    }
}
