//
//  FolderCreationViewController.swift
//  Bob
//
//  Created by Isabelle Melchiori on 02/04/2019.
//  Copyright © 2019 Bob. All rights reserved.
//
import UIKit

class FolderListVC: UIViewController {
    
    lazy var userFolders = [UserFolder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HeaderBuilderBob.setTokenInHeader()
        UserService.folders(query: "user/2/folder", header: HeaderBuilderBob.headers) { (test, e) in
            print("yo",test)
        }
        
    }
        // Do any additional setup after loading the view.
}


/*
 // MARK: - Navigation
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */
