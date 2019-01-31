//
//  FolderDetails.swift
//  Bob
//
//  Created by Victor Lucas on 28/01/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit

class FolderDetailsVC: ImagePickerViewController {

    @IBAction func addDocument(_ sender: Any) {
        chooseImage()
    }
    @IBOutlet weak var titleLabel: UILabel!
    
    var folderTitle:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(title: "Custom", style: .plain, target: self, action: nil)
        navigationItem.setLeftBarButton(backButton, animated: false)
        self.navigationController?.isNavigationBarHidden = false
        self.titleLabel.text = folderTitle
    }
    
    //Mark: - Image picker selection
    
    override func didSelectImage(image: UIImage) {
        print("Youpi j'ai mon image")
        
        if let data = image.pngData() {
            // ici on a l'image (en PNG) au format binaire
            // on peut ensuite l'envoyer via un multipart request 🥳
        }
    }
}
