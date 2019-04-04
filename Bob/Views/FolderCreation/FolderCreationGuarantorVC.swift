//
//  FolderCreationViewController.swift
//  Bob
//
//  Created by Isabelle Melchiori on 02/04/2019.
//  Copyright © 2019 Bob. All rights reserved.
//
import UIKit

class FolderCreationGuarantorVC: UIViewController {
    
    @IBOutlet weak var folderCreationGuarantorTableView: UITableView!
    
    override func viewDidLoad() {
        self.folderCreationGuarantorTableView.delegate = self
        self.folderCreationGuarantorTableView.dataSource = self
    }
    
}

extension FolderCreationGuarantorVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.folderCreationGuarantorTableView.dequeueReusableCell(withIdentifier: "folderCreationGuarantorCell", for: indexPath) as! FolderCreationTableViewCell
        cell.titleFolderCreationCategoryFile.text = "guarant"
        return cell
    }
    
    
}

