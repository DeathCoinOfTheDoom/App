import UIKit

class DeleteFolderVC: UIViewController {
    var deleteFolderId : String?
    
    @IBAction func deleteButton(_ sender: Any) {
        if let deleteFolderId = deleteFolderId {
            HeaderBuilderBob.setTokenInHeader()
            FolderService.delete(query: "folder/\(deleteFolderId)", header: HeaderBuilderBob.headers) {
            }
        }
    }
    @IBOutlet weak var ModalIndicationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
        ModalIndicationLabel.font = UIFont(name: Fonts.poppinsSemiBold, size: 18)
        ModalIndicationLabel.textColor = ColorConstant.White
    }
    
}

