import UIKit

class FolderCreationResidencyVC: UIViewController {
    var previousVCIds : [String] = []
    // list of userFiles lazy displayed in the table cells
    lazy var userFiles = [UserFilesData]()
    // ids passed to the next view. Necessary to create the folder during the final step
    var finalUserFilesIds : [String] = []
    lazy var categoryDetails = [CategoryDetailsData]()
    // ids of subdocument possibly display in this step
    var userFilesDataIds : [String] = []
    // Data from previous VC
    var folderTitle : String = ""
    @IBOutlet weak var folderCreationResidencyTableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toFolderCreationGuarantorVC"){
            if (finalUserFilesIds.count > 0) {
                let displayVC = segue.destination as! FolderCreationGuarantorVC
                displayVC.previousVCIds =  self.previousVCIds + self.finalUserFilesIds
                displayVC.folderTitle = self.folderTitle
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
        self.folderCreationResidencyTableView.delegate = self
        self.folderCreationResidencyTableView.dataSource = self
        self.navigationItem.title = folderTitle
        let localStorageInstance = LocalStorage()
        let userId = localStorageInstance.getUserInfos(key: "id")
        HeaderBuilderBob.setTokenInHeader()
        CategoryService.details(query: "category/3/type", header: HeaderBuilderBob.headers) { (categoryDetails, error) in
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
                self.folderCreationResidencyTableView.reloadData()
            }
        }
    }
}

extension FolderCreationResidencyVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.userFiles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.folderCreationResidencyTableView.dequeueReusableCell(withIdentifier: "folderCreationResidencyCell", for: indexPath) as! FolderCreationTableViewCell
        let index = self.userFilesDataIds.firstIndex(of:userFiles[indexPath.section].relationships.type.data.id);
        cell.titleFolderCreationCategoryFile.text = self.categoryDetails[index!].attributes.title
        cell.iconBgFolderCreationCategoryFile.rounded()
        cell.iconFolderCreationCategoryFile.image = UIImage(named: "add")
        cell.titleFolderCreationCategoryFile.textColor = ColorConstant.Neutral.DARKEST
        cell.iconBgFolderCreationCategoryFile.backgroundColor = ColorConstant.Neutral.DARKEST
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
        cell.backgroundFolderCreationCategory.backgroundColor = UIColor(red:1.00, green:0.95, blue:0.77, alpha:1.0)
        cell.titleFolderCreationCategoryFile.textColor = ColorConstant.Neutral.DARKEST
        cell.iconBgFolderCreationCategoryFile.backgroundColor = UIColor(red:0.98, green:0.85, blue:0.41, alpha:1.0)
        cell.iconFolderCreationCategoryFile.image = UIImage(named: "check")
    }
    func styleUnactiveCell (cell: FolderCreationTableViewCell) {
        cell.backgroundFolderCreationCategory.backgroundColor = ColorConstant.White
        cell.titleFolderCreationCategoryFile.textColor = ColorConstant.Neutral.DARKEST
        cell.iconBgFolderCreationCategoryFile.backgroundColor = ColorConstant.Neutral.DARKEST
        cell.iconFolderCreationCategoryFile.image = UIImage(named: "add")
    }
}

