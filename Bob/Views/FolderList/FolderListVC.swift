import UIKit
import MessageUI

class FolderListVC: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBAction func sendEmail(_ sender: Any) {
    }
    func configureMailController(folderId: String) {
        FolderService.one(query: "folder/\(folderId)?zip", header: HeaderBuilderBob.headers) { (userFolder, e) in
            if let userFolder = userFolder {
                if (userFolder.meta != nil) {
                    self.displayEmail(zip: userFolder.meta!.zip)
                }
            }
        }
    }
    func displayEmail(zip: String) {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([""])
        mailComposerVC.setSubject("")
        mailComposerVC.setMessageBody("Trouvez le lien pour télécharger mon dossier ici: \(zip)", isHTML: false)
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposerVC, animated: true, completion: nil)
        } else {
            print("error email")
        }
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    private let refreshControl = UIRefreshControl()
    @IBAction func emptyFlashFolderCreation(_ sender: Any) {
        createFlashFolder()
    }
    
    @IBAction func filledflashFolderCreation(_ sender: Any) {
        createFlashFolder()
    }
    
    func createFlashFolder() {
        let localStorageInstance = LocalStorage()
        let userId = localStorageInstance.getUserInfos(key: "id")
        FolderService.creation(query: "folder", payload: ["user_id": userId, "default": "1", "title": "Dossier par defaut"], header: HeaderBuilderBob.headers){ (folder, e) in
            FolderService.listing(query: "user/\(userId)/folder", header: HeaderBuilderBob.headers) { (userFolders, e) in
                self.userFolders.removeAll()
                self.userFolders.append(contentsOf: userFolders)
                self.mainTableView.reloadData()
                self.mainTableView.restore()
            }
        }
    }
    func fetchData() {
        HeaderBuilderBob.setTokenInHeader()
        let localStorageInstance = LocalStorage()
        let userId = localStorageInstance.getUserInfos(key: "id")
        FolderService.listing(query: "user/\(userId)/folder", header: HeaderBuilderBob.headers) { (userFolders, e) in
            if (userFolders.count == 0) {
                self.userFolders.removeAll()
                self.mainTableView.reloadData()
                self.mainTableView.setEmptyView(title: "Aucun dossiers", message: "Vous n'avez aucun dossiers pour le moment, vous pouvez en créer un dès maintenant.")
            } else {
                self.userFolders.removeAll()
                self.userFolders.append(contentsOf: userFolders)
                self.mainTableView.reloadData()
                self.mainTableView.restore()
            }
            self.refreshControl.endRefreshing()
        }
    }
    
    @IBOutlet weak var mainTableView: UITableView!
    lazy var userFolders = [UserFolderData]()
    let cellIdentifier = "basic_cell_identifier"
    var selectedCellIndexPath: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTabbarItems(self: self)
        self.fetchData()
        self.configurationRefreshControl()
    }
    func configurationRefreshControl() {
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            mainTableView.refreshControl = refreshControl
        } else {
            mainTableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshFolderData(_:)), for: .valueChanged)
        refreshControl.tintColor = ColorConstant.Primary.BASE
    }
    @objc private func refreshFolderData(_ sender: Any) {
        fetchData()
    }
    func applyCellStyle(tableCell: FolderCell) {
        tableCell.folderTitle.font = UIFont(name: Fonts.poppinsMedium, size: 14)
        tableCell.backgroundColor = ColorConstant.White
        tableCell.folderCard.backgroundColor = ColorConstant.White
    }
}

        
extension FolderListVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.userFolders.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        return headerView
    }
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mainTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FolderCell
        cell.folderTitle.text = self.userFolders[indexPath.section].attributes.title
        cell.selectionStyle = .none
        self.applyCellStyle(tableCell: cell)
        cell.sendFolder = {
            self.configureMailController(folderId: self.userFolders[indexPath.section].id)
        }
        cell.deleteFolder = {
            let nextViewController  = self.storyboard?.instantiateViewController(withIdentifier: "DeleteFolderVC") as! DeleteFolderVC
            nextViewController.deleteFolderId = self.userFolders[indexPath.section].id
            self.present(nextViewController, animated: true, completion: nil)
        }
        return cell
    }
}



extension UITableView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        // The only tricky part is here:
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
