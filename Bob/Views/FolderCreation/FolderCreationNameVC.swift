//
//  FolderCreationViewController.swift
//  Bob
//
//  Created by Isabelle Melchiori on 02/04/2019.
//  Copyright © 2019 Bob. All rights reserved.
//
import UIKit

class FolderCreationNameVC: UIViewController {
    @IBAction func buttonFolderName(_ sender: Any) {
        if (inputFolderName.text!.count > 0) {
            let localStorageInstance = LocalStorage()
            let userId = localStorageInstance.getUserInfos(key: "id")
            FolderService.creation(query: "folder", payload: ["user_id": userId, "title": inputFolderName.text!], header: HeaderBuilderBob.headers){ (folder, e) in
                print("folder", folder)
                let storyBoard : UIStoryboard = UIStoryboard(name: "Folder", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FolderCreationIdentity") as! UINavigationController
                self.present(nextViewController, animated:true, completion:nil)
            }
        }
    }
    @IBOutlet weak var inputFolderName: Input!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
