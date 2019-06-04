import UIKit

class FolderDetailsVC: UIViewController {
    var folderId : String?
    var folderTitle : String = ""
    lazy var folderFiles = [UserFiles]()
    
    @IBOutlet weak var folderDetailsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("folderId", folderId, "folderTitle", folderTitle)
        self.folderDetailsTableView.delegate = self
        self.folderDetailsTableView.dataSource = self
        self.navigationItem.title = folderTitle
        fetchData()
    }
    func fetchData() {
        if let folderId = folderId {
            HeaderBuilderBob.setTokenInHeader()
            FolderService.one(query: "folder/\(folderId)", header: HeaderBuilderBob.headers) { (folderFiles, error) in
                print("folderFiles", folderFiles)
            }
        }
    }
}
extension FolderDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.folderDetailsTableView.dequeueReusableCell(withIdentifier: "folderDetailsCell", for: indexPath) as! FolderDetailsCellVC
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FolderDetailsCellVC
        styleCell(cell: cell)
        cell.selectionStyle = .none
    }
        
    func styleCell (cell: FolderDetailsCellVC) {
        cell.folderDetailsBackgroundImage.backgroundColor = ColorConstant.Primary.BASE
        cell.folderDetailsLabel.textColor = ColorConstant.Neutral.DARKEST
    }
}
