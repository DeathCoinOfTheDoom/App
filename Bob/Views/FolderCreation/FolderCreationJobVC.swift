//
//  FolderCreationViewController.swift
//  Bob
//
//  Created by Isabelle Melchiori on 02/04/2019.
//  Copyright © 2019 Bob. All rights reserved.
//
import UIKit

class FolderCreationJobVC: UIViewController {
    
    @IBOutlet weak var folderCreationJobTableView: UITableView!
   
    override func viewDidLoad() {
        self.folderCreationJobTableView.delegate = self
        self.folderCreationJobTableView.dataSource = self
    }
    
}

extension FolderCreationJobVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.folderCreationJobTableView.dequeueReusableCell(withIdentifier: "folderCreationJobCell", for: indexPath) as! FolderCreationTableViewCell
        cell.titleFolderCreationCategoryFile.text = "emploi"
        return cell
    }
    
    
}

