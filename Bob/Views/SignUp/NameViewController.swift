import UIKit

class NameViewController: UIViewController {

    
    @IBOutlet weak var FirstName: Input!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var DestViewController: BirthdayViewController = segue.destination as! BirthdayViewController
        DestViewController.birthdayTitleText = FirstName.text!
    }
}
