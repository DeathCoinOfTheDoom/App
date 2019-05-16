import UIKit

class AuthCodeVC: KeyboardController, AuthCodeTextFieldDelegate {
    var phoneNumber : String = ""
    
    @IBAction func resendAuthCode(_ sender: Any) {
        LoginService.validation(query: "auth/sms", payload: ["phone_num": phoneNumber], header: HeaderBuilderBob.headers, phone: self.phoneNumber){ (code, e) in
        }
    }
    
    // index of the selected item in collectionOfTextField
    var actualStep = 0
    // events
    @IBOutlet weak var helpTip: UILabel!
    @IBOutlet var collectionOfTextField: Array<UITextField> = []
    @IBOutlet weak var resendAuthButton: UIButton!
    @IBAction func onChangeInput(_ sender: AnyObject) {
        increaseActualStep()
        inputEnable(actualStep: actualStep)
        if (checkFieldsAreFull()) {
            let code = codeConcatValues(inputValues: collectionOfTextField)
            LoginService.authCode(query: "auth/login", payload: ["token": code], header: HeaderBuilderBob.headers) { (user, e) in
                if let token = user?.token {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NameViewController") as! NameViewController
                    nextViewController.user = user?.user
                    nextViewController.userToken = token
                    self.present(nextViewController, animated:true, completion:nil)
                }
            }
        }   
    }
    func didPressBackspace(textField: AuthCodeTextField) {
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
    
    func checkFieldsAreFull() -> Bool {
        let areFieldsFull = collectionOfTextField.allSatisfy { $0.text?.count == 1 }
        return areFieldsFull
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        additionalStyle()
        for item in collectionOfTextField {
            item.delegate = self
        }
    }
    
    
    func inputEnable(actualStep: Int){
        var actualStep = actualStep
        for (index, textField) in collectionOfTextField.enumerated() {
            if (index == actualStep) {
                textField.isEnabled = true
                collectionOfTextField[actualStep].becomeFirstResponder()
                actualStep = index
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
    func additionalStyle() {
        // helpTip
        helpTip.font =  UIFont(name: Fonts.poppinsSemiBold, size: 14)
        helpTip.textColor = ColorConstant.Neutral.LIGHT
        // resendAuthCode
        resendAuthButton.tintColor = ColorConstant.Primary.BASE
        resendAuthButton.titleLabel?.textColor = ColorConstant.Primary.LIGHT
        resendAuthButton.titleLabel?.font = UIFont(name: Fonts.poppinsSemiBold, size: 14)
    }
}
