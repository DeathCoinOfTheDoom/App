import UIKit

class CategoryDetailsVC: CategoryDetailsImagePickerVC {
    
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var completeIconImage: UIImageView!
    @IBOutlet weak var completeIcon: UIView!
    @IBOutlet weak var titleFolderDetails: TitleLabel!
    @IBOutlet weak var descriptionFolderDetails: UILabel!
    @IBAction func addDocument(_ sender: Any) {
        self.chooseImage()
    }
    @IBOutlet weak var titleLabel: UILabel!
    
    lazy var categoryDetails = [CategoryDetailsData]()
    lazy var userFiles = [UserFilesData]()
    var folderCategory:CategoryData?
    var userFilesDataIds : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailsTableView.delegate = self
        self.detailsTableView.dataSource = self
        if let folderCategoryNotNull = folderCategory {
            self.titleLabel.text = folderCategoryNotNull.attributes.title
            self.descriptionFolderDetails.text = folderCategoryNotNull.attributes.extendedDescription
            HeaderBuilderBob.setTokenInHeader()
            CategoryService.details(query: "category/\(folderCategoryNotNull.id)/type", header: HeaderBuilderBob.headers) { (categoryDetails, error) in
                UserService.getFiles(query: "user/2/file", header: HeaderBuilderBob.headers) { (userFiles, error) in
                    self.userFiles.append(contentsOf: userFiles)
                    userFiles.forEach({ (userFilesData) in
                        self.userFilesDataIds.append(userFilesData.id)
                    })
                    self.categoryDetails.removeAll()
                    self.categoryDetails.append(contentsOf: self.categoryFilesExtended(categoryDetails: categoryDetails))
                    self.detailsTableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
        self.applyStyle()
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
        // icon
        completeIcon.rounded()
        completeIcon.tintColor = ColorConstant.Error.ERROR
        // title
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
            completeIcon.backgroundColor = ColorConstant.Green.Primary
            tableCell.categoryDetailsCellCard.backgroundColor = ColorConstant.Green.Primary
            tableCell.categoryDetailsCellIconBg.backgroundColor = ColorConstant.Green.Dark
            tableCell.categoryDetailsCellTitle.textColor = ColorConstant.White
            tableCell.categoryDetailsCellIcon.image = UIImage(named: "Logo")
        }
        else {
            tableCell.categoryDetailsCellIcon.image = UIImage(named: "Logo")
            tableCell.categoryDetailsCellIconBg.backgroundColor = ColorConstant.Neutral.DARKEST
            tableCell.categoryDetailsCellCard.backgroundColor = ColorConstant.White
        }
    }
    //Mark: - Image picker selection
    override func didSelectImage(image: UIImage) {
        if let data = image.pngData() {
            print("oui l'image", data)
            // ici on a l'image (en PNG) au format binaire
            // on peut ensuite l'envoyer via un multipart request 🥳
        }
    }
}

extension CategoryDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoryDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = self.detailsTableView.dequeueReusableCell(withIdentifier: "CategoryDetailsCell", for: indexPath) as! CategoryDetailsCell
        tableCell.categoryDetailsCellTitle.text = self.categoryDetails[indexPath.row].attributes.title
        self.applyCellStyle(tableCell: tableCell, userAsDoneThisFile:
            self.categoryDetails[indexPath.row].userAsDoneThisFile)
        completeIcon.backgroundColor = ColorConstant.Green.Primary
        return tableCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
