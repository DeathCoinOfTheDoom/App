//
//  ViewController.swift
//  Bob
//
//  Created by Victor Lucas on 28/01/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit

class FoldersVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let tmpTab:[Folder] = [Folder(title: "Identité"), Folder(title: "Garant"), Folder(title: "Emploi"), Folder(title: "Domicile")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}

extension FoldersVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tmpTab.count + 1 // + 1 : pour une cellule +
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen().bounds.size.width
        let nbColPerRow: CGFloat = 2
        return CGSize(width: screenWidth / nbColPerRow, height: screenWidth / nbColPerRow)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.row
        let lastIndex = self.tmpTab.count
        
        if index==lastIndex {
            // -> retourne la cellule +
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "AddCell", for: indexPath) as! AddFolderCell
            return cell
        } else {
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "FolderCell", for: indexPath) as! FolderCell
            
            cell.titleLabel.text = self.tmpTab[indexPath.row].title
            cell.backgroundColor = .white
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextViewController  = self.storyboard?.instantiateViewController(withIdentifier: "FolderDetails") as! FolderDetailsVC
        
        nextViewController.folderTitle = tmpTab[indexPath.row].title
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}

