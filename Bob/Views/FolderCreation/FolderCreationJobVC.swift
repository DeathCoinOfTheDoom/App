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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toFolderCreationResidencyVC"){
            if (finalUserFilesIds.count > 0) {
                let displayVC = segue.destination as! FolderCreationResidencyVC
                displayVC.previousVCIds =  self.previousVCIds + self.finalUserFilesIds
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
        print("previousVCIds", previousVCIds)
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userFiles.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.folderCreationJobTableView.dequeueReusableCell(withIdentifier: "folderCreationJobCell", for: indexPath) as! FolderCreationTableViewCell
        print("cell", cell)
        let index = self.userFilesDataIds.firstIndex(of:userFiles[indexPath.row].relationships.type.data.id);
        cell.titleFolderCreationCategoryFile.text = self.categoryDetails[index!].attributes.title
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
        cell.backgroundFolderCreationCategory.backgroundColor = ColorConstant.Green.Primary
        cell.titleFolderCreationCategoryFile.textColor = ColorConstant.White
    }
    func styleUnactiveCell (cell: FolderCreationTableViewCell) {
        cell.backgroundFolderCreationCategory.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
        cell.titleFolderCreationCategoryFile.textColor = UIColor.darkGray
    }
}
