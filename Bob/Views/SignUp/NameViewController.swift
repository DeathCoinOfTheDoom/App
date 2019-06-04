import UIKit

class NameViewController: UIViewController {
    @IBOutlet weak var firstName: Input!
    @IBOutlet weak var lastName: Input!
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EmailVC {
            if var user = user {
                user.attributes.lastName = lastName.text!
                user.attributes.firstName = firstName.text!
                destination.user = user
            }
        }
    }
}
