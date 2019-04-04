//
//  FolderCreationViewController.swift
//  Bob
//
//  Created by Isabelle Melchiori on 02/04/2019.
//  Copyright © 2019 Bob. All rights reserved.
//
import UIKit

class FolderCreationIdentityVC: UIViewController {
    @IBOutlet weak var folderCreationCategoryTableView: UITableView!
    override func viewDidLoad() {
        self.folderCreationCategoryTableView.delegate = self
        self.folderCreationCategoryTableView.dataSource = self
    }
    
}
extension FolderCreationIdentityVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.folderCreationCategoryTableView.dequeueReusableCell(withIdentifier: "folderCreationIdentityCell", for: indexPath) as! FolderCreationTableViewCell
        cell.titleFolderCreationCategoryFile.text = "test"
        return cell
    }
    
    
}

