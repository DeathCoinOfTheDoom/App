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
        self.titleLabel.text = folderTitle
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    //Mark: - Image picker selection
    
    override func didSelectImage(image: UIImage) {
        if let data = image.pngData() {
            print("oui l'image", data)
            // ici on a l'image (en PNG) au format binaire
            // on peut ensuite l'envoyer via un multipart request 🥳
        }
    }
}
