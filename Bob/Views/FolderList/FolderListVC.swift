//
//  FolderCreationViewController.swift
//  Bob
//
//  Created by Isabelle Melchiori on 02/04/2019.
//  Copyright © 2019 Bob. All rights reserved.
//
import UIKit

class FolderListVC: UIViewController {
    @IBAction func test(_ sender: Any) {
        print("salut-------")
    }
    //    @IBAction func fillAction(_ sender: Any) {
//        values.append(contentsOf: ["un", "deux", "trois", "quatre"])
//        mainTableView.reloadData()
//        mainTableView.restore()
//
//    }
//    @IBAction func emptyAction(_ sender: Any) {
//
//        values.removeAll()
//        mainTableView.reloadData()
//        mainTableView.setEmptyView(title: "cest vide", message: "vrmt vide")
//    }
    
    @IBOutlet weak var mainTableView: UITableView!
    
//    @IBAction func fillAction(_ sender: Any) {
//        values.append(contentsOf: ["un", "deux", "trois", "quatre"])
//        mainTableView.reloadData()
//        mainTableView.restore()
//
//    }
//    @IBAction func emptyAction(_ sender: Any) {
//
//        values.removeAll()
//        mainTableView.reloadData()
//        mainTableView.setEmptyView(title: "cest vide", message: "vrmt vide")
//    }
    
    let cellIdentifier = "basic_cell_identifier"
    
    lazy var userFolders = [UserFolderData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HeaderBuilderBob.setTokenInHeader()
        UserService.getFolders(query: "user/2/folder", header: HeaderBuilderBob.headers) { (userFolders, e) in
            if (userFolders.count == 0) {
                self.userFolders.removeAll()
                self.mainTableView.reloadData()
                self.mainTableView.setEmptyView(title: "Aucun dossiers", message: "Vous n'avez aucun dossiers pour le moment, vous pouvez dès maintenant en créer un.")
            } else {
                self.userFolders.removeAll()
                self.userFolders.append(contentsOf: userFolders)
                self.mainTableView.reloadData()
                self.mainTableView.restore()
            }
        }
    }
}

        
extension FolderListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userFolders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mainTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = self.userFolders[indexPath.row].attributes.title
        return cell
    }
}

extension UITableView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        // The only tricky part is here:
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
    }
    
   
}
