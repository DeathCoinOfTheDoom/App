import UIKit

class FolderCreationNameVC: KeyboardController {
    @IBAction func buttonFolderName(_ sender: Any) {
        if (inputFolderName.text!.count > 0) {
            let localStorageInstance = LocalStorage()
            let userId = localStorageInstance.getUserInfos(key: "id")
            FolderService.creation(query: "folder", payload: ["user_id": userId, "title": inputFolderName.text!], header: HeaderBuilderBob.headers){ (folder, e) in
                let storyBoard : UIStoryboard = UIStoryboard(name: "Folder", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FolderCreationIdentity") as! UINavigationController
                let firstRenderedView = nextViewController.viewControllers.first as! FolderCreationIdentityVC
                if (folder != nil) {
                    firstRenderedView.folderTitle = folder!.attributes.title
                    firstRenderedView.folderId = folder!.id
                    self.present(nextViewController, animated:true, completion:nil)
                }
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
