//
//  ViewController.swift
//  Bob
//
//  Created by Victor Lucas on 28/01/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit

class FoldersVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let tmpTab:[Folder] = [Folder(title: "Identité", description: "I am a description I am a description I am a description one"), Folder(title: "Garant", description: "I am a description I am a description I am a description two"), Folder(title: "Emploi", description: "I am a description I am a description I am a description three"), Folder(title: "Domicile", description: "I am a description I am a description I am a description four")]
    let cellSpacingHeight: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
}

extension FoldersVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tmpTab.count
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
        tableCell.titleTableCell.text = self.tmpTab[indexPath.section].title
        tableCell.descriptionTableCell.text = self.tmpTab[indexPath.section].description
        // style part
        tableCell.layer.cornerRadius = 8
        tableCell.clipsToBounds = true
        tableCell.backgroundColor = .white
        return tableCell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController  = self.storyboard?.instantiateViewController(withIdentifier: "FolderDetails") as! FolderDetailsVC
        nextViewController.folderTitle = tmpTab[indexPath.row].title
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
