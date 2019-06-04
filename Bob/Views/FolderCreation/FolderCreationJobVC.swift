import UIKit

class FolderCreationJobVC: UIViewController {
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toFolderCreationResidencyVC"){
            if (finalUserFilesIds.count > 0) {
                let displayVC = segue.destination as! FolderCreationResidencyVC
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
    
    @IBOutlet weak var folderCreationJobTableView: UITableView!
   
    override func viewDidLoad() {
        self.folderCreationJobTableView.delegate = self
        self.folderCreationJobTableView.dataSource = self
        let localStorageInstance = LocalStorage()
        let userId = localStorageInstance.getUserInfos(key: "id")
        HeaderBuilderBob.setTokenInHeader()
        CategoryService.details(query: "category/4/type", header: HeaderBuilderBob.headers) { (categoryDetails, error) in
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
                self.folderCreationJobTableView.reloadData()
            }
        }
    }
}

extension FolderCreationJobVC: UITableViewDelegate, UITableViewDataSource {
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
        return 10;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.folderCreationJobTableView.dequeueReusableCell(withIdentifier: "folderCreationJobCell", for: indexPath) as! FolderCreationTableViewCell
        print("cell", cell)
        let index = self.userFilesDataIds.firstIndex(of:userFiles[indexPath.row].relationships.type.data.id);
        cell.titleFolderCreationCategoryFile.text = self.categoryDetails[index!].attributes.title
        cell.iconBgFolderCreationCategoryFile.rounded()
        cell.iconFolderCreationCategoryFile.image = UIImage(named: "add")
        cell.titleFolderCreationCategoryFile.textColor = ColorConstant.Neutral.DARKEST
        cell.iconBgFolderCreationCategoryFile.backgroundColor = ColorConstant.Neutral.DARKEST
        cell.backgroundFolderCreationCategory.backgroundColor = ColorConstant.White
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FolderCreationTableViewCell
        cell.selectionStyle = .none
        // already in array delete the element
        let indexOfId = finalUserFilesIds.firstIndex(of: userFiles[indexPath.row].id)
        if ((indexOfId) != nil) {
            finalUserFilesIds.remove(at: indexOfId!)
            styleUnactiveCell(cell: cell)
        }
        // not in the array add the element and apply the selected style
        else {
            finalUserFilesIds.append(userFiles[indexPath.row].id)
            styleActiveCell(cell: cell)
        }
    }
    func styleActiveCell (cell: FolderCreationTableViewCell) {
        print("cell" , cell, "backgroundFolderCreationCategory", cell.backgroundFolderCreationCategory)
        cell.backgroundFolderCreationCategory.backgroundColor = UIColor(red:0.78, green:0.97, blue:0.89, alpha:1.0)
        cell.titleFolderCreationCategoryFile.textColor = ColorConstant.Neutral.DARKEST
        cell.iconBgFolderCreationCategoryFile.backgroundColor = ColorConstant.Green.Dark
        cell.iconFolderCreationCategoryFile.image = UIImage(named: "check")
    }
    func styleUnactiveCell (cell: FolderCreationTableViewCell) {
        cell.backgroundFolderCreationCategory.backgroundColor = ColorConstant.White
        cell.titleFolderCreationCategoryFile.textColor = ColorConstant.Neutral.DARKEST
        cell.iconBgFolderCreationCategoryFile.backgroundColor = ColorConstant.Neutral.DARKEST
        cell.iconFolderCreationCategoryFile.image = UIImage(named: "add")
    }
}
