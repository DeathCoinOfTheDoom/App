import UIKit

class FolderDetailsVC: UIViewController {
    var folderId : String?
    var folderTitle : String = ""
    lazy var userFiles = [UserFilesData]()
    var categories = [CategoryData]()
    
    @IBOutlet weak var folderDetailsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.folderDetailsTableView.delegate = self
        self.folderDetailsTableView.dataSource = self
        self.navigationItem.title = folderTitle
        fetchData()
    }
    func fetchData() {
        if let folderId = folderId {
            HeaderBuilderBob.setTokenInHeader()
            CategoryService.all(query: "category", header: HeaderBuilderBob.headers) { (categories, error) in
                self.categories.append(contentsOf: categories)
                FolderService.one(query: "folder/\(folderId)", header: HeaderBuilderBob.headers) { (folderFiles, error) in
                    folderFiles?.data.relationships.files.data.forEach({ (userFolderRelationshipsData) in
                        UserService.getOneFiles(query: "file/\(userFolderRelationshipsData.id)", header: HeaderBuilderBob.headers) { (userFile, error) in
                            if let userFile = userFile {
                                self.userFiles.append(userFile)
                            }
                            self.folderDetailsTableView.reloadData()
                        }
                    })
                }
            }
        }
    }
}
extension FolderDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.userFiles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90;
    }
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.folderDetailsTableView.dequeueReusableCell(withIdentifier: "folderDetailsCell", for: indexPath) as! FolderDetailsCellVC
        cell.folderDetailsLabel.text = userFiles[indexPath.section].relationships.type.data.id
        styleCell(cell: cell)
        let colors = [ColorConstant.Secondary.PINK,ColorConstant.Secondary.BLUE, ColorConstant.Secondary.YELLOW, ColorConstant.Secondary.GREEN]
        let ids = [["1","2","3"],["4", "5", "6", "7", "8", "9"],["10", "11", "12", "13", "14", "15"], ["16", "17", "18", "19", "20", "21"]]
        var finalIndex = 0
        for (index, subIds) in ids.enumerated() {
            subIds.forEach { (id) in
                if (id == userFiles[indexPath.section].relationships.type.data.id) {
                    finalIndex = index
                }
            }
        }
        cell.folderDetailsBackgroundImage.backgroundColor = colors[finalIndex]
        let urlImage:URL = URL(string: categories[finalIndex].attributes.icon)!
        cell.folderDetailsImage.af_setImage(withURL: urlImage)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FolderDetailsCellVC
        cell.selectionStyle = .none
    }
        
    func styleCell (cell: FolderDetailsCellVC) {
        cell.folderDetailsLabel.textColor = ColorConstant.Neutral.DARKEST
        cell.folderDetailsBackgroundImage.rounded()
    }
}
