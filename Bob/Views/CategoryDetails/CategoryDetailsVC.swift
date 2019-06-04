import UIKit

class CategoryDetailsVC: CategoryDetailsImagePickerVC {
    
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var titleFolderDetails: TitleLabel!
    @IBOutlet weak var descriptionFolderDetails: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    lazy var categoryDetails = [CategoryDetailsData]()
    lazy var userFiles = [UserFilesData]()
    var folderCategory:CategoryData?
    var userFilesDataIds : [String] = []
    var indexOfClickedCell : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailsTableView.delegate = self
        self.detailsTableView.dataSource = self
        if let folderCategoryNotNull = folderCategory {
            self.titleLabel.text = folderCategoryNotNull.attributes.title
            self.descriptionFolderDetails.text = folderCategoryNotNull.attributes.extendedDescription
        }
        self.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
        self.applyStyle()
    }
    
    func fetchData() {
        if let folderCategoryNotNull = folderCategory {
        HeaderBuilderBob.setTokenInHeader()
        let localStorageInstance = LocalStorage()
        let userId = localStorageInstance.getUserInfos(key: "id")
            CategoryService.details(query: "category/\(folderCategoryNotNull.id)/type", header: HeaderBuilderBob.headers) { (categoryDetails, error) in
                UserService.getFiles(query: "user/\(userId)/file", header: HeaderBuilderBob.headers) { (userFiles, error) in
                    self.userFiles.append(contentsOf: userFiles)
                    userFiles.forEach({ (userFilesData) in self.userFilesDataIds.append(userFilesData.relationships.type.data.id)
                    })
                    self.categoryDetails.removeAll()
                    self.categoryDetails.append(contentsOf: self.categoryFilesExtended(categoryDetails: categoryDetails))
                    self.detailsTableView.reloadData()
                }
            }
        }
    }
    // Here we are setting the value of idsOfDoneFiles to know if a documents as been already given
    func categoryFilesExtended(categoryDetails: [CategoryDetailsData]) -> [CategoryDetailsData] {
        let userFilesExtended: [CategoryDetailsData] = categoryDetails.map { (categoryDetails) -> CategoryDetailsData in
            if (self.userFilesDataIds.contains(categoryDetails.id)) {
                let categoryDetailsExtended = self.categoryWithUserKnownStatus(status: true, categoryDetails: categoryDetails)
                return categoryDetailsExtended
            }
             let categoryDetailsExtended = self.categoryWithUserKnownStatus(status: false, categoryDetails: categoryDetails)
            return categoryDetailsExtended
        }
        return userFilesExtended
    }
    
    func categoryWithUserKnownStatus(status: Bool, categoryDetails:CategoryDetailsData) -> CategoryDetailsData {
        var categoryDetailsExtended: CategoryDetailsData = categoryDetails
        categoryDetailsExtended.userAsDoneThisFile = status
        return categoryDetailsExtended
    }
    
    func applyStyle() {
        titleFolderDetails.font = UIFont(name: Fonts.poppinsBold, size: 24)
        // description
        descriptionFolderDetails.font = UIFont(name: Fonts.poppinsMedium, size: 14)
        self.view.backgroundColor = ColorConstant.Neutral.LIGHTER
        detailsTableView.backgroundColor = ColorConstant.Neutral.LIGHTER
    }
    
    func applyCellStyle(tableCell: CategoryDetailsCell ,userAsDoneThisFile: Bool?) {
        tableCell.categoryDetailsCellIconBg.rounded()
        tableCell.backgroundColor = ColorConstant.Neutral.LIGHTER
        if (userAsDoneThisFile!) {
            tableCell.categoryDetailsCellCard.backgroundColor = ColorConstant.Green.Primary
            tableCell.categoryDetailsCellIconBg.backgroundColor = ColorConstant.Green.Dark
            tableCell.categoryDetailsCellTitle.textColor = ColorConstant.White
            tableCell.categoryDetailsCellIcon.image = UIImage(named: "check")
        }
        else {
            tableCell.categoryDetailsCellIcon.image = UIImage(named: "add")
            tableCell.categoryDetailsCellIconBg.backgroundColor = ColorConstant.Neutral.DARKEST
            tableCell.categoryDetailsCellCard.backgroundColor = ColorConstant.White
        }
    }
    //Mark: - Image picker selection
    override func didSelectImage(image: UIImage) {
        let resizedImage = image.resized(toWidth: 200.0)
        if (resizedImage != nil) {
            if let data = resizedImage!.pngData() {
                HeaderBuilderBob.setTokenInHeader()
                let localStorageInstance = LocalStorage()
                let userId = localStorageInstance.getUserInfos(key: "id")
                FilesService.postImage(query: "file", imageData: data, payload: ["user_id" : userId, "file_type_id" : categoryDetails[indexOfClickedCell!].id] ,header: HeaderBuilderBob.headers) {
                    self.fetchData()
                }
            }
        }
    }
}

extension CategoryDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoryDetails.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexOfClickedCell = indexPath.row
        self.chooseImage()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = self.detailsTableView.dequeueReusableCell(withIdentifier: "CategoryDetailsCell", for: indexPath) as! CategoryDetailsCell
        tableCell.categoryDetailsCellTitle.text = self.categoryDetails[indexPath.row].attributes.title
        self.applyCellStyle(tableCell: tableCell, userAsDoneThisFile:
            self.categoryDetails[indexPath.row].userAsDoneThisFile)
        tableCell.selectionStyle = .none
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
