import UIKit

class CategoryDetailsVC: ImagePickerViewController {
    
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var completeIcon: UIView!
    @IBOutlet weak var titleFolderDetails: TitleLabel!
    @IBOutlet weak var descriptionFolderDetails: UILabel!
    @IBAction func addDocument(_ sender: Any) {
        chooseImage()
    }
    @IBOutlet weak var titleLabel: UILabel!
    
    lazy var categoryDetails = [CategoryDetailsData]()
    var folderCategory:CategoryData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailsTableView.delegate = self
        self.detailsTableView.dataSource = self
        if let folderCategoryNotNull = folderCategory {
            self.titleLabel.text = folderCategoryNotNull.attributes.title
            self.descriptionFolderDetails.text = folderCategoryNotNull.attributes.extendedDescription
            HeaderBuilderBob.setToken(token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjE1MThkOWNlMDBjZDkwNTQ3ODFiZTU3YTM5ZGRmZTA4YjFhZTBmZmQ1ZjhhZjVmNzhjZTRhNzJjZDQ5MjI1YjhlYjNjZWYzZTFlNzE4YWUwIn0.eyJhdWQiOiIxIiwianRpIjoiMTUxOGQ5Y2UwMGNkOTA1NDc4MWJlNTdhMzlkZGZlMDhiMWFlMGZmZDVmOGFmNWY3OGNlNGE3MmNkNDkyMjViOGViM2NlZjNlMWU3MThhZTAiLCJpYXQiOjE1NTI0ODU1OTAsIm5iZiI6MTU1MjQ4NTU5MCwiZXhwIjoxNTg0MTA3OTkwLCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.DfqctIg9ov8_QpY7iIGiHCjwsNHn3vZbE64mHZjA045lo_qdS8eEz2gTXw6zaea4wMmkRJjCK4yy9Wl51QElirW0lxKhrBPdpEv4PSKY7LjCQyiYtVIzGWiKH2-mSgm-h1zDtFzOoT8Ee-cvXd5sUkbQrhQ43gGlWTvhgPVf9oFM11nukgpplbKb5OAFIqgzDVcIBqRme2Bb5I8h8zAOiAjP0Z7aaD8dNpUM5TWw37Aobr6m-NgUUChs41soQletnigrokx1NTKvlD33_G-FlDEWkAIRpfy8SqkniQkXU4HyasbnDfUCHFlJkkQKt6d2N76w_gxcxxeNhDC7MFzcBXtuqX_ywLpBVoWZz6M-BHlTw4z74i4JVq97aw9ZTKu6ZZfXFIRnlRt9v0f7iV6gkuIqeOvpK1-2k_pU0a3EQ670jOljiGaikUMID94oZuD_l3jykgVHF5-xF8wpJXSsHiSrBPjysJnp5hBnfx3iAkn41hq-6a2vvBhRYrVkfnzlG00wIYmfVQGM8h01vguoTPw0FlueYtt2_SyDFTHiV04aS5Y3yPVNXApzPg4PNaX51dqN3qBivnqwi3wySpZmQSAACE-wlEcVmFVTmN9H5MXX8AB9A2J__AVWqEH-DF-Mb6SpN8-Vv7sy5Dp9sEhzsNqX3_wX3i9udv56LvN7aoM")
            CategoryService.details(query: "category/\(folderCategoryNotNull.id)/type", header: HeaderBuilderBob.headers) { (categoryDetails, error) in
                print("categoryDetails", categoryDetails)
                self.categoryDetails.removeAll()
                self.categoryDetails.append(contentsOf: categoryDetails)
                self.detailsTableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
        self.applyStyle()
    }
    
    func applyStyle() {
        // icon
        completeIcon.layer.cornerRadius = 100
        completeIcon.layer.backgroundColor = ColorConstant.Success.BASE.cgColor
        completeIcon.tintColor = ColorConstant.Neutral.DARKEST
        // title
        titleFolderDetails.font = UIFont(name: Fonts.poppinsBold, size: 24)
        // description
        descriptionFolderDetails.font = UIFont(name: Fonts.poppinsMedium, size: 14)
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
        let tableCell = self.detailsTableView.dequeueReusableCell(withIdentifier: "FolderCell", for: indexPath) as! CategoryDetailsCell
        print("self.categoryDetails[indexPath.row]", self.categoryDetails[indexPath.row])
        tableCell.categoryDetailsCellTitle.text = self.categoryDetails[indexPath.row].attributes.title
        return tableCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
