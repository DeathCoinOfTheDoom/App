import UIKit
import AlamofireImage

class CategoryVC: UIViewController {
    // UI components
    @IBOutlet weak var homeTitle: UILabel!
    @IBOutlet weak var subTitleFolderList: UILabel!
    @IBOutlet weak var titleFolderList: UILabel!
    @IBOutlet weak var tableView: UITableView!
    // hold result of network call
    lazy var categoriesTab = [CategoryData]()
    lazy var userFiles = [UserFilesData]()
    // Static data
    let cellSpacingHeight: CGFloat = 10
    let progressColor = [ColorConstant.Secondary.PINK, ColorConstant.Secondary.BLUE, ColorConstant.Secondary.YELLOW, ColorConstant.Secondary.GREEN]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTabbarItems(self: self)
        let localStorageInstance = LocalStorage()
        let userId = localStorageInstance.getUserInfos(key: "id")
        HeaderBuilderBob.setTokenInHeader()
        UserService.getUserInfos(query: "user/\(userId)", header: HeaderBuilderBob.headers) { (userInfos, e) in
            guard e == nil else {
                print(e!.localizedDescription)
                return
            }
            guard let userInfos = userInfos else {
                print("no result found")
                return
            }
            self.homeTitle.text = "Bonjour " + userInfos.attributes.firstName + ","
        }
        CategoryService.all(query: "category", header: HeaderBuilderBob.headers) { (categories, error) in
            UserService.getFiles(query: "user/\(userId)/file", header: HeaderBuilderBob.headers) { (userFiles, error) in
                self.userFiles.append(contentsOf: userFiles)
                self.categoriesTab.removeAll()
                self.categoriesTab.append(contentsOf: categories)
                self.tableView.reloadData()
            }
        }
        self.styleFolderList()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func styleFolderList() {
        titleFolderList.font = UIFont(name: Fonts.poppinsBold, size: 22)
        titleFolderList.textColor = ColorConstant.Neutral.DARKEST
        subTitleFolderList.font = UIFont(name: Fonts.poppinsRegular, size: 14)
    }
    
    func determineProgression(index: Int) -> Float {
        let total = self.categoriesTab[index].relationships.type.data.count
        var counter = 0
        let acceptedIds : [String] = self.categoriesTab[index].relationships.type.data.map({ (CategoryRelationshipsTypeData) -> String in
            return CategoryRelationshipsTypeData.id
        })
        
        self.userFiles.forEach { (userFileData) in
            if (acceptedIds.contains(userFileData.relationships.type.data.id)) {
                counter = counter + 1
            }
        }
        return Float(counter)/Float(total)
    }
}


extension CategoryVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.categoriesTab.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = self.tableView.dequeueReusableCell(withIdentifier: "CategoryListCell", for: indexPath) as! CategoryCell
        // set pregress of the UiProgressBar
        tableCell.progressCategoryCell.progress = self.determineProgression(index: indexPath.section)
        // dinamic content
        tableCell.titleCategoryCell.text = self.categoriesTab[indexPath.section].attributes.title
        tableCell.descriptionCategoryCell.text = self.categoriesTab[indexPath.section].attributes.description
        let urlImage:URL = URL(string: self.categoriesTab[indexPath.section].attributes.icon)!
        tableCell.imageCategoryCell.af_setImage(withURL: urlImage)
        // style part
        tableCell.progressCategoryCell.tintColor = progressColor[indexPath.section]
        tableCell.progressCategoryCell.trackTintColor = ColorConstant.Border.LIGHT
        tableCell.layer.cornerRadius = 8
        tableCell.clipsToBounds = true
        tableCell.backgroundColor = .white
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController  = self.storyboard?.instantiateViewController(withIdentifier: "CategoryDetails") as! CategoryDetailsVC
        nextViewController.folderCategory = self.categoriesTab[indexPath.section]
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}

