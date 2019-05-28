import UIKit

class ProfilConsultationVC: UIViewController {
    // outlets
    @IBOutlet weak var birthdayProfilConsultation: UnchangeableInputLabel!
    @IBOutlet weak var emailProfilConsultation: UnchangeableInputLabel!
    @IBOutlet weak var firstNameProfilConsultation: UnchangeableInputLabel!
    @IBOutlet weak var lastNameProfilConsultation: UnchangeableInputLabel!
    var userInfos = UserInfosAttrView(email: "", firstName: "", lastName: "", birthdate: "", phoneNumber: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        HeaderBuilderBob.setTokenInHeader()
        let localStorageInstance = LocalStorage()
        let userId = localStorageInstance.getUserInfos(key: "id")
        UserService.getUserInfos(query: "user/\(userId)", header: HeaderBuilderBob.headers) { (userInfos, e) in
            guard e == nil else {
                print(e!.localizedDescription)
                return
            }
            guard let userInfos = userInfos else {
                print("no result found")
                return
            }
            self.userInfos.lastName = userInfos.attributes.lastName
            self.userInfos.phoneNumber = userInfos.attributes.phoneNumber
            self.userInfos.firstName = userInfos.attributes.firstName
            self.userInfos.birthdate = userInfos.attributes.birthdate
            self.userInfos.email = userInfos.attributes.email ?? ""
            self.applyDataToView(userInfos: userInfos.attributes)
        }
    }
    func applyDataToView(userInfos: UserInfosAttr) {
        self.lastNameProfilConsultation.text = userInfos.lastName
        self.firstNameProfilConsultation.text = userInfos.firstName
        self.birthdayProfilConsultation.text = userInfos.birthdate
        self.emailProfilConsultation.text = userInfos.email
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ProfilUpdateVC {
            destination.userAttrBeforeModif = self.userInfos
        }
    }
}
