//
//  ViewController.swift
//  Bob
//
//  Created by Victor Lucas on 28/01/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit
import AlamofireImage

class CategoryVC: UIViewController {

    @IBOutlet weak var subTitleFolderList: UILabel!
    @IBOutlet weak var titleFolderList: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    lazy var categoriesTab = [CategoryData]()
    let cellSpacingHeight: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HeaderBuilderBob.setToken(token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6Ijg2NzI5ZjcwYjgxOGI5MmU2ODVhMzJmMmI2YzY2ODI5MjQ0YjIwNmE2ZDI0MGJlY2QzOTM2YjJjOWNmNDAzMmUzNmY1NjMzYzRiODFhYWE0In0.eyJhdWQiOiIxIiwianRpIjoiODY3MjlmNzBiODE4YjkyZTY4NWEzMmYyYjZjNjY4MjkyNDRiMjA2YTZkMjQwYmVjZDM5MzZiMmM5Y2Y0MDMyZTM2ZjU2MzNjNGI4MWFhYTQiLCJpYXQiOjE1NTQzODExMTIsIm5iZiI6MTU1NDM4MTExMiwiZXhwIjoxNTg2MDAzNTEyLCJzdWIiOiIzMCIsInNjb3BlcyI6W119.HA4CG08yJQsPKwOfhZkyEDQq40efPHHffspNNpUXFnbnOcSrYzUiAg0uXj6WgY44QjlvDugyy63hk02vuYHdNUvkKOioHeLPFm_1ifLvSqnkjC79DMbVBFAzH-FIZYAQdZEEE2pPTcvCO40pVVmS1GAxlhgAujPoxsCy-ZNm3W7DYdg8JUYx83k5VKEDZOB75FKXsSJyX1cd7a4e65BnjfsOYopas0e36iwLp_oa1qHx1jNfA9xuvsMGiUuTps5ols6ok06I7MJaGUirLLw4IoUJLcpBuDdUoAjL32zLTo75e7ePWNRzp1q3LR9Vy0D3PfGPuIHvZDJZiWAGDCvy-S-rhMlzqNh5E68h6tqtGyP1padF0OLad5_n1YKwZ3JR4IK9OBhNzcXXwsuNkcreJIoxhQs_DGHt6J0w4JlQ3XE9HcFvyKD0LfoDFJq9HNgUh3QmDp2KEMjgbZ-eDrPuTd5y2k0dvtkV7B5VK1sF1QNUGIzqplOrkhe3G4K2ko3uUY1dc7elBeuXaxLmJpvraCxWUJleskN60PgvYrAl9A60OSpjM-E5q1r1hVUuYi2fQ-h-qzQrrhAab0AmfGweVzIveSHNEp2T7FtleXReEu1zB80CmtR9u9eKWwAZbR8YxNPYa6NKYxSWpBdfBebyaaHlkDHM1wgYbkOjzWyyF8k")
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
    
    func styleFolderList() {
        titleFolderList.font = UIFont(name: Fonts.poppinsBold, size: 22)
        titleFolderList.textColor = ColorConstant.Neutral.DARKEST
        subTitleFolderList.font = UIFont(name: Fonts.poppinsRegular, size: 14)
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
        let nextViewController  = self.storyboard?.instantiateViewController(withIdentifier: "CategoryDetails") as! CategoryDetailsVC
        nextViewController.folderCategory = categoriesTab[indexPath.row]
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}

