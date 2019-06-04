import UIKit

class FolderCreationGuarantorVC: UIViewController {
    var previousVCIds : [String] = []
    // list of userFiles lazy displayed in the table cells
    lazy var userFiles = [UserFilesData]()
    var finalUserFilesIds : [String] = []
    lazy var categoryDetails = [CategoryDetailsData]()
    // ids of subdocument possibly display in this step
    var userFilesDataIds : [String] = []
    // Data from previous VC
    var folderTitle : String = ""
    
    @IBAction func sendFilesButton(_ sender: Any) {
        HeaderBuilderBob.setTokenInHeader()
        let localStorageInstance = LocalStorage()
        let userId = localStorageInstance.getUserInfos(key: "id")
        let parameters = ["title": folderTitle, "user_id": userId, "files": finalUserFilesIds + previousVCIds, "_method": "put"] as [String : Any]
        FolderService.creation(query: "folder", payload: ["user_id": userId, "title": folderTitle], header: HeaderBuilderBob.headers){ (folder, e) in
            if let folder = folder {
                FolderService.modification(query: "folder/\(folder.id)", payload: parameters, header: HeaderBuilderBob.headers) { (createdFolder, error) in
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainTBVC") as! UITabBarController
                    nextViewController.selectedIndex = 1
                    self.present(nextViewController, animated:true, completion:nil)
                }
            }
        }
    }
    @IBOutlet weak var folderCreationGuarantorTableView: UITableView!
    
    override func viewDidLoad() {
        self.folderCreationGuarantorTableView.delegate = self
        self.folderCreationGuarantorTableView.dataSource = self
        let localStorageInstance = LocalStorage()
        let userId = localStorageInstance.getUserInfos(key: "id")
        HeaderBuilderBob.setTokenInHeader()
        CategoryService.details(query: "category/2/type", header: HeaderBuilderBob.headers) { (categoryDetails, error) in
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
                self.folderCreationGuarantorTableView.reloadData()
            }
        }
    }
    
}

extension FolderCreationGuarantorVC: UITableViewDelegate, UITableViewDataSource {
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
        let cell = self.folderCreationGuarantorTableView.dequeueReusableCell(withIdentifier: "folderCreationGuarantorCell", for: indexPath) as! FolderCreationTableViewCell
        cell.titleFolderCreationCategoryFile.text = self.categoryDetails[indexPath.section].attributes.title
        cell.iconBgFolderCreationCategoryFile.rounded()
        cell.iconFolderCreationCategoryFile.image = UIImage(named: "add")
        cell.titleFolderCreationCategoryFile.textColor = ColorConstant.Neutral.DARKEST
        cell.iconBgFolderCreationCategoryFile.backgroundColor = ColorConstant.Neutral.DARKEST
//        cell.backgroundFolderCreationCategory.backgroundColor = ColorConstant.White
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
        cell.backgroundFolderCreationCategory.backgroundColor = UIColor(red:0.70, green:0.92, blue:0.99, alpha:1.0)
        cell.titleFolderCreationCategoryFile.textColor = ColorConstant.Neutral.DARKEST
        cell.iconBgFolderCreationCategoryFile.backgroundColor = UIColor(red:0.63, green:0.82, blue:0.89, alpha:1.0)
        cell.iconFolderCreationCategoryFile.image = UIImage(named: "check")
    }
    func styleUnactiveCell (cell: FolderCreationTableViewCell) {
        cell.backgroundFolderCreationCategory.backgroundColor = ColorConstant.White
        cell.titleFolderCreationCategoryFile.textColor = ColorConstant.Neutral.DARKEST
        cell.iconBgFolderCreationCategoryFile.backgroundColor = ColorConstant.Neutral.DARKEST
        cell.iconFolderCreationCategoryFile.image = UIImage(named: "add")
    }
}
