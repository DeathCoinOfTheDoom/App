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
            HeaderBuilderBob.setToken(token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjE1MThkOWNlMDBjZDkwNTQ3ODFiZTU3YTM5ZGRmZTA4YjFhZTBmZmQ1ZjhhZjVmNzhjZTRhNzJjZDQ5MjI1YjhlYjNjZWYzZTFlNzE4YWUwIn0.eyJhdWQiOiIxIiwianRpIjoiMTUxOGQ5Y2UwMGNkOTA1NDc4MWJlNTdhMzlkZGZlMDhiMWFlMGZmZDVmOGFmNWY3OGNlNGE3MmNkNDkyMjViOGViM2NlZjNlMWU3MThhZTAiLCJpYXQiOjE1NTI0ODU1OTAsIm5iZiI6MTU1MjQ4NTU5MCwiZXhwIjoxNTg0MTA3OTkwLCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.DfqctIg9ov8_QpY7iIGiHCjwsNHn3vZbE64mHZjA045lo_qdS8eEz2gTXw6zaea4wMmkRJjCK4yy9Wl51QElirW0lxKhrBPdpEv4PSKY7LjCQyiYtVIzGWiKH2-mSgm-h1zDtFzOoT8Ee-cvXd5sUkbQrhQ43gGlWTvhgPVf9oFM11nukgpplbKb5OAFIqgzDVcIBqRme2Bb5I8h8zAOiAjP0Z7aaD8dNpUM5TWw37Aobr6m-NgUUChs41soQletnigrokx1NTKvlD33_G-FlDEWkAIRpfy8SqkniQkXU4HyasbnDfUCHFlJkkQKt6d2N76w_gxcxxeNhDC7MFzcBXtuqX_ywLpBVoWZz6M-BHlTw4z74i4JVq97aw9ZTKu6ZZfXFIRnlRt9v0f7iV6gkuIqeOvpK1-2k_pU0a3EQ670jOljiGaikUMID94oZuD_l3jykgVHF5-xF8wpJXSsHiSrBPjysJnp5hBnfx3iAkn41hq-6a2vvBhRYrVkfnzlG00wIYmfVQGM8h01vguoTPw0FlueYtt2_SyDFTHiV04aS5Y3yPVNXApzPg4PNaX51dqN3qBivnqwi3wySpZmQSAACE-wlEcVmFVTmN9H5MXX8AB9A2J__AVWqEH-DF-Mb6SpN8-Vv7sy5Dp9sEhzsNqX3_wX3i9udv56LvN7aoM")
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
