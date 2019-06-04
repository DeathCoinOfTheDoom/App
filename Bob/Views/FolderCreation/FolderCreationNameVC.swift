import UIKit

class FolderCreationNameVC: KeyboardController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "folderCreationIdentityVCSegue"){
            if (inputFolderName.text!.count > 0) {
                let displayVC = segue.destination as! FolderCreationIdentityVC
                displayVC.folderTitle = inputFolderName.text!
            }
        }
    }
    @IBOutlet weak var inputFolderName: Input!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
