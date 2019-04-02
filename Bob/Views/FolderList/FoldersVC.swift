//
//  ViewController.swift
//  Bob
//
//  Created by Victor Lucas on 28/01/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit
import AlamofireImage

class FoldersVC: UIViewController {

    @IBOutlet weak var subTitleFolderList: UILabel!
    @IBOutlet weak var titleFolderList: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    lazy var categoriesTab = [CategoryData]()
    let cellSpacingHeight: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HeaderBuilderBob.setToken(token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjE1MThkOWNlMDBjZDkwNTQ3ODFiZTU3YTM5ZGRmZTA4YjFhZTBmZmQ1ZjhhZjVmNzhjZTRhNzJjZDQ5MjI1YjhlYjNjZWYzZTFlNzE4YWUwIn0.eyJhdWQiOiIxIiwianRpIjoiMTUxOGQ5Y2UwMGNkOTA1NDc4MWJlNTdhMzlkZGZlMDhiMWFlMGZmZDVmOGFmNWY3OGNlNGE3MmNkNDkyMjViOGViM2NlZjNlMWU3MThhZTAiLCJpYXQiOjE1NTI0ODU1OTAsIm5iZiI6MTU1MjQ4NTU5MCwiZXhwIjoxNTg0MTA3OTkwLCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.DfqctIg9ov8_QpY7iIGiHCjwsNHn3vZbE64mHZjA045lo_qdS8eEz2gTXw6zaea4wMmkRJjCK4yy9Wl51QElirW0lxKhrBPdpEv4PSKY7LjCQyiYtVIzGWiKH2-mSgm-h1zDtFzOoT8Ee-cvXd5sUkbQrhQ43gGlWTvhgPVf9oFM11nukgpplbKb5OAFIqgzDVcIBqRme2Bb5I8h8zAOiAjP0Z7aaD8dNpUM5TWw37Aobr6m-NgUUChs41soQletnigrokx1NTKvlD33_G-FlDEWkAIRpfy8SqkniQkXU4HyasbnDfUCHFlJkkQKt6d2N76w_gxcxxeNhDC7MFzcBXtuqX_ywLpBVoWZz6M-BHlTw4z74i4JVq97aw9ZTKu6ZZfXFIRnlRt9v0f7iV6gkuIqeOvpK1-2k_pU0a3EQ670jOljiGaikUMID94oZuD_l3jykgVHF5-xF8wpJXSsHiSrBPjysJnp5hBnfx3iAkn41hq-6a2vvBhRYrVkfnzlG00wIYmfVQGM8h01vguoTPw0FlueYtt2_SyDFTHiV04aS5Y3yPVNXApzPg4PNaX51dqN3qBivnqwi3wySpZmQSAACE-wlEcVmFVTmN9H5MXX8AB9A2J__AVWqEH-DF-Mb6SpN8-Vv7sy5Dp9sEhzsNqX3_wX3i9udv56LvN7aoM")
        CategoryService.all(query: "category", header: HeaderBuilderBob.headers) { (categories, error) in
            self.categoriesTab.removeAll()
            self.categoriesTab.append(contentsOf: categories)
            self.tableView.reloadData()
        }
        self.styleFolderList()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let onboardingViewController = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController") as? OnboardingViewController {
            present(onboardingViewController, animated: true, completion: nil)
        }
    }
    func styleFolderList() {
        titleFolderList.font = UIFont(name: Fonts.poppinsBold, size: 22)
        titleFolderList.textColor = ColorConstant.Neutral.DARKEST
        subTitleFolderList.font = UIFont(name: Fonts.poppinsRegular, size: 14)
    }
}

extension FoldersVC: UITableViewDelegate, UITableViewDataSource {
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
        let tableCell = self.tableView.dequeueReusableCell(withIdentifier: "FolderCell", for: indexPath) as! FolderCell
        tableCell.titleTableCell.text = self.categoriesTab[indexPath.section].attributes.title
        tableCell.descriptionTableCell.text = self.categoriesTab[indexPath.section].attributes.description
        let urlImage:URL = URL(string: self.categoriesTab[indexPath.section].attributes.icon)!
        tableCell.imageTableCell.af_setImage(withURL: urlImage)
        // style part
        tableCell.layer.cornerRadius = 8
        tableCell.clipsToBounds = true
        tableCell.backgroundColor = .white
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController  = self.storyboard?.instantiateViewController(withIdentifier: "FolderDetails") as! FolderDetailsVC
        nextViewController.folderCategory = categoriesTab[indexPath.row]
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
