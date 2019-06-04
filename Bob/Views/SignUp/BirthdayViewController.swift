import UIKit

class BirthdayViewController: UIViewController {
    // Infos from the previous VC
    var user: User?
    var userToken: String?
    // UI components
    @IBAction func endUserModification(_ sender: Any) {
        if let user = user {
            let parameters = [
                "phone_number": user.attributes.phoneNumber,
                "lastName": user.attributes.lastName!,
                "firstName": user.attributes.firstName!,
                "birthdate": user.attributes.birthdate!,
                "email": user.attributes.email!,
                "_method": "put",
                ] as [String : String]
            HeaderBuilderBob.setTokenInHeader()
            UserService.postUserInfos(query: "user/\(user.id)", payload: parameters, header: HeaderBuilderBob.headers) { (userModified, error) in
                if (error != nil) {
                    print("error", error!)
                }
                else {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainTBVC") as! UITabBarController
                    self.present(nextViewController, animated:true, completion:nil)
                }
            }
        }
    }
    @IBOutlet weak var BirthdayPicker: UITextField!
    @IBOutlet weak var BirthdayTitle: TitleLabel!
    
    lazy var formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BirthdayTitle.text = "Dernière étape ! \n Quelle est votre date de naissance \(user?.attributes.firstName ?? "") ?"
        let birthdayPicker = UIDatePicker()
        birthdayPicker.datePickerMode = UIDatePicker.Mode.date
        birthdayPicker.locale = Locale(identifier: "fr_FR")
        birthdayPicker.addTarget(self, action: #selector(BirthdayViewController.birthdayPickerValueChange(sender: )), for: UIControl.Event.valueChanged)
        BirthdayPicker.inputView = birthdayPicker
    }
    
    @objc func birthdayPickerValueChange(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        user?.attributes.birthdate = formatter.string(from: sender.date)
        formatter.dateStyle = DateFormatter.Style.long
        formatter.timeStyle = DateFormatter.Style.none
        formatter.locale = Locale(identifier: "fr_FR")
        BirthdayPicker.text = formatter.string(from: sender.date)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
