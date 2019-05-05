import UIKit

class BirthdayViewController: UIViewController {
    // UI components
    @IBOutlet weak var BirthdayPicker: UITextField!
    @IBOutlet weak var BirthdayTitle: TitleLabel!
    @IBAction func NextStepButton(_ sender: Any) {
        if let user = user {
        let parameters = [
            "phone_number": user.attributes.phoneNumber,
            "email": user.attributes.email!,
            "lastName": user.attributes.lastName!,
            "firstName": user.attributes.lastName!,
            "birthdate": user.attributes.birthdate!,
            ] as [String : Any]
            UserService.update(query: "user/\(user.id)", payload: parameters, header: HeaderBuilderBob.headersPut) { (userModified, error) in
                if (error == nil) {
                    print("error", error!)
                }
                else {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainTBVC") as! UINavigationController
                    self.present(nextViewController, animated:true, completion:nil)
                }
            }
        }
    }
    // Infos from the previous VC
    var user: User?
    var userToken: String?
    
    lazy var formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BirthdayTitle.text = "Quelle est votre date de naissance \(user?.attributes.lastName ?? "") ?"
        
        let birthdayPicker = UIDatePicker()
        birthdayPicker.datePickerMode = UIDatePicker.Mode.date
        birthdayPicker.locale = Locale(identifier: "fr_FR")
        birthdayPicker.addTarget(self, action: #selector(BirthdayViewController.birthdayPickerValueChange(sender: )), for: UIControl.Event.valueChanged)
        BirthdayPicker.inputView = birthdayPicker
    }
    
    @objc func birthdayPickerValueChange(sender: UIDatePicker) {
        user?.attributes.birthdate = sender.date
        formatter.dateStyle = DateFormatter.Style.long
        formatter.timeStyle = DateFormatter.Style.none
        formatter.locale = Locale(identifier: "fr_FR")
        BirthdayPicker.text = formatter.string(from: sender.date)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
