//
//  FolderCreationViewController.swift
//  Bob
//
//  Created by Isabelle Melchiori on 02/04/2019.
//  Copyright © 2019 Bob. All rights reserved.
//
import UIKit

class FolderCreationResidencyVC: UIViewController {
    
    @IBOutlet weak var folderCreationResidencyTableView: UITableView!

    override func viewDidLoad() {
        self.folderCreationResidencyTableView.delegate = self
        self.folderCreationResidencyTableView.dataSource = self
    }

}

extension FolderCreationResidencyVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.folderCreationResidencyTableView.dequeueReusableCell(withIdentifier: "folderCreationResidencyCell", for: indexPath) as! FolderCreationTableViewCell
        cell.titleFolderCreationCategoryFile.text = "domicile"
        return cell
    }


}

