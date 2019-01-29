//
//  TextFieldMaxLength.swift
//  hyra-tabbed
//
//  Created by Gérome Lacaux on 21/01/2019.
//  Copyright © 2019 hyra. All rights reserved.
//

import Foundation
import UIKit

// 1
private var maxLengths = [UITextField: Int]()

// 2
extension UITextField {
    
    // 3
    @IBInspectable var maxLength: Int {
        get {
            // 4
            guard let length = maxLengths[self] else {
                return Int.max
            }
            return length
        }
        set {
            maxLengths[self] = newValue
            // 5
            addTarget(
                self,
                action: #selector(limitLength),
                for: UIControl.Event.editingChanged
            )
        }
    }
    
    @objc func limitLength(textField: UITextField) {
        // 6
        guard let prospectiveText = textField.text, prospectiveText.count > maxLength else {
                return
        }
        
        let selection = selectedTextRange
        // 7
        text = String(prospectiveText[
            prospectiveText.startIndex ..< prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)])
        selectedTextRange = selection
    }
    
}
