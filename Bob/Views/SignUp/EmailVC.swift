
import UIKit

class EmailVC: UIViewController {
    // UI components
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EmailVC {
            if var user = user {
//                user.attributes.email = email.text!
                destination.user = user
            }
        }
    }
}
