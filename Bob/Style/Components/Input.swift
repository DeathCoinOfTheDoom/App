//
//  Input.swift
//  Bob
//
//  Created by Isabelle Melchiori on 29/01/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import Foundation
import UIKit

class Input : UITextField, UITextFieldDelegate {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addTarget(self, action: #selector(onFocusIn), for: UIControl.Event.editingDidBegin)
        self.addTarget(self, action: #selector(onFocusOut), for: UIControl.Event.editingDidEnd)
        self.layer.borderWidth = 1
        self.layer.borderColor = ColorConstant.Border.BASE.cgColor
        self.layer.cornerRadius = 10
        self.font = UIFont(name: Fonts.poppinsMedium, size: 18)
        self.tintColor = ColorConstant.Neutral.DARKEST
        self.textColor = ColorConstant.Neutral.DARKEST
    }
    
    @objc func onFocusIn(textField: UITextField) {
        applyColor(color: ColorConstant.Primary.BASE)
    }
    @objc func onFocusOut(textField: UITextField) {
        applyColor(color: ColorConstant.Neutral.DARKEST)
    }
    
    
    func applyColor(color: UIColor) {
        self.layer.borderColor = color.cgColor  // Set Border-Color
    }
    
    @IBInspectable var hasError: Bool = false {
        didSet {
            if (hasError) {
                self.layer.borderColor = UIColor.red.cgColor
                
            } else {
                self.layer.borderColor = ColorConstant.Neutral.LIGHT.cgColor
            }
        }
    }
    
    //Padding input
    
    let padding = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

