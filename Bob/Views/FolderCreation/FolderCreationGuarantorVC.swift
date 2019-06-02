import UIKit

class FolderCreationGuarantorVC: UIViewController {
    var previousVCIds : [String] = []
    // list of userFiles lazy displayed in the table cells
    lazy var userFiles = [UserFilesData]()
    // ids passed to the next view. Necessary to create the folder during the final step
    var finalUserFilesIds : [String] = []
    lazy var categoryDetails = [CategoryDetailsData]()
    // ids of subdocument possibly display in this step
    var userFilesDataIds : [String] = []
    
    @IBAction func sendFilesButton(_ sender: Any) {
    }
    @IBOutlet weak var folderCreationGuarantorTableView: UITableView!
    
    override func viewDidLoad() {
        self.folderCreationGuarantorTableView.delegate = self
        self.folderCreationGuarantorTableView.dataSource = self
        let localStorageInstance = LocalStorage()
        print("previousVCIds", previousVCIds)
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userFiles.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.folderCreationGuarantorTableView.dequeueReusableCell(withIdentifier: "folderCreationGuarantorCell", for: indexPath) as! FolderCreationTableViewCell
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
        cell.backgroundFolderCreationCategory.backgroundColor = ColorConstant.Green.Primary
        cell.titleFolderCreationCategoryFile.textColor = ColorConstant.White
    }
    func styleUnactiveCell (cell: FolderCreationTableViewCell) {
        cell.backgroundFolderCreationCategory.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
        cell.titleFolderCreationCategoryFile.textColor = UIColor.darkGray
    }
}
