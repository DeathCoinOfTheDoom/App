import UIKit

class NameViewController: UIViewController {
    var user: User?
    
    @IBOutlet weak var firstName: Input!
    @IBOutlet weak var lastName: Input!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BirthdayViewController {
            if var user = user {
                user.attributes.lastName = lastName.text!
                user.attributes.firstName = firstName.text!
                destination.user = user
            }
        }
    }

}
