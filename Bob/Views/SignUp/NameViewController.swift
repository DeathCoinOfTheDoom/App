import UIKit

class NameViewController: UIViewController {
    var user: User?
    var userToken : String?
    
    @IBOutlet weak var firstName: Input!
    @IBOutlet weak var lastName: Input!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let NextViewController: BirthdayViewController = segue.destination as! BirthdayViewController
        if var user = user {
            user.attributes.lastName = lastName.text!
            user.attributes.firstName = firstName.text!
            NextViewController.user = user
        }
    }
}
