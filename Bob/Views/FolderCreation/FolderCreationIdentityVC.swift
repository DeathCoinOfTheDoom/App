import UIKit

class FolderCreationIdentityVC: UIViewController {
    @IBOutlet weak var folderCreationIdentityTableView: UITableView!
    // Data from previous VC
    var folderTitle : String = ""
    var folderId: String = ""
    // list of userFiles lazy displayed in the table cells
    lazy var userFiles = [UserFilesData]()
    // ids passed to the next view. Necessary to create the folder during the final step
    var finalUserFilesIds : [String] = []
    lazy var categoryDetails = [CategoryDetailsData]()
    // ids of subdocument possibly display in this step
    var userFilesDataIds : [String] = []
    let cellSpacingHeight: CGFloat = 10
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toFolderCreationJobVC"){
            if (finalUserFilesIds.count > 0) {
                let displayVC = segue.destination as! FolderCreationJobVC
                displayVC.previousVCIds = finalUserFilesIds
                displayVC.folderTitle = self.folderTitle
                displayVC.folderId = self.folderId
            }
        }
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (finalUserFilesIds.count > 0) {
            return true
        } else {
            return false
        }
    }
    
    override func viewDidLoad() {
        self.folderCreationIdentityTableView.delegate = self
        self.folderCreationIdentityTableView.dataSource = self
        print("folderTitle", folderTitle)
        let localStorageInstance = LocalStorage()
        let userId = localStorageInstance.getUserInfos(key: "id")
        HeaderBuilderBob.setTokenInHeader()
        CategoryService.details(query: "category/1/type", header: HeaderBuilderBob.headers) { (categoryDetails, error) in
            self.categoryDetails.append(contentsOf: categoryDetails)
            UserService.getFiles(query: "user/\(userId)/file", header: HeaderBuilderBob.headers) { (userFiles, error) in
                self.userFiles.removeAll()
                categoryDetails.forEach({ (categoryDetailsData) in
                    self.userFilesDataIds.append(categoryDetailsData.id)
                })
                userFiles.forEach({ (userFilesData) in
                    if (self.userFilesDataIds.contains(userFilesData.relationships.type.data.id)) {
                        self.userFiles.append(userFilesData)
                    }
                })
                self.folderCreationIdentityTableView.reloadData()
            }
        }
    }
    
}
extension FolderCreationIdentityVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.userFiles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.folderCreationIdentityTableView.dequeueReusableCell(withIdentifier: "folderCreationIdentityCell", for: indexPath) as! FolderCreationTableViewCell
        let index = self.userFilesDataIds.firstIndex(of:userFiles[indexPath.section].relationships.type.data.id);
        cell.titleFolderCreationCategoryFile.text = self.categoryDetails[index!].attributes.title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FolderCreationTableViewCell
        cell.selectionStyle = .none
        // already in array delete the element
        let indexOfId = finalUserFilesIds.firstIndex(of: userFiles[indexPath.section].id)
        if ((indexOfId) != nil) {
            finalUserFilesIds.remove(at: indexOfId!)
            styleUnactiveCell(cell: cell)
        }
        // not in the array add the element and apply the selected style
        else {
            finalUserFilesIds.append(userFiles[indexPath.section].id)
            styleActiveCell(cell: cell)
        }
    }
    func styleActiveCell (cell: FolderCreationTableViewCell) {
        cell.backgroundFolderCreationCategory.backgroundColor = ColorConstant.Green.Primary
        cell.titleFolderCreationCategoryFile.textColor = ColorConstant.White
    }
    func styleUnactiveCell (cell: FolderCreationTableViewCell) {
        cell.backgroundFolderCreationCategory.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
        cell.titleFolderCreationCategoryFile.textColor = UIColor.darkGray
    }
}

