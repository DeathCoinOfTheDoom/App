//
//  SetpTwo.swift
//  Bob
//
//  Created by Victor Lucas on 28/01/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit

class StepTwoVC: UIViewController, PinTexFieldDelegate {
    
    // index of the selected item in collectionOfTextField
    var actualStep = 0
    // events
    @IBOutlet var collectionOfTextField: Array<UITextField> = []
    @IBAction func onChangeInput(_ sender: AnyObject) {
        increaseActualStep()
        inputEnable(actualStep: actualStep)
        checkFieldsAreFull()
    }
    func didPressBackspace(textField: PinTextField) {
        if (collectionOfTextField[actualStep].text == "") {
            decreaseActualStep()
            inputEnable(actualStep: actualStep)
            collectionOfTextField[actualStep].text = ""
        }
    }
    func decreaseActualStep() {
        if (actualStep >= 1) {
            actualStep += -1
        }
    }
    func increaseActualStep() {
        if (actualStep <= collectionOfTextField.count) {
            actualStep += 1
        }
    }
    
    func checkFieldsAreFull() {
        let areFieldsFull = collectionOfTextField.map { (elementOfCollection) -> Bool in
            if ( elementOfCollection.text?.count == 1) {
                return true
            }
            else {
                return false
            }
        }
        print(areFieldsFull)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputEnable(actualStep: actualStep)
        let code = codeConcatValues(inputValues: collectionOfTextField)
        for item in collectionOfTextField {
            item.delegate = self
        }
    }
    func inputEnable(actualStep: Int){
        for (index, textField) in collectionOfTextField.enumerated() {
            if (index == actualStep) {
                textField.isEnabled = true
                collectionOfTextField[actualStep].becomeFirstResponder()
            }
            else {
                textField.isEnabled = false
            }
        }
    }
    
    func codeConcatValues(inputValues: Array<UITextField>) -> String {
        let codeValues: String = inputValues.reduce("", { accumulator, nextInputValue in
            accumulator + nextInputValue.text!
        })
        return codeValues
    }
}
