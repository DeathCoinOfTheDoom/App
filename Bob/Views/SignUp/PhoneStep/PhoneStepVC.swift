import UIKit
import PhoneNumberKit
import FlagPhoneNumber

class PhoneStepVc: KeyboardController {
    @IBOutlet weak var phoneInput: FPNTextField!
    @IBAction func  phoneSendButton(_ sender: Any) {
        if let phoneValue = phoneInput.getFormattedPhoneNumber(format: .International) {
            self.view.endEditing(true)
            LoginService.validation(query: "auth/sms", payload: ["phone_num": phoneValue], header: HeaderBuilderBob.headers, phone: phoneValue){ (code, e) in
                if e != nil {
                    print("error", e!)
                }
                print("code", code)
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AuthCodeVC") as! AuthCodeVC
                nextViewController.phoneNumber = phoneValue
                self.present(nextViewController, animated:true, completion:nil)
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
