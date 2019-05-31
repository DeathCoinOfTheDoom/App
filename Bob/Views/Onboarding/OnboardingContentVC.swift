//
//  OnboardingContentViewController.swift
//  Bob
//
//  Created by Isabelle Melchiori on 19/03/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit

class OnboardingContentVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var headingLabel: UILabel! {
        didSet {
            headingLabel.numberOfLines = 4
        }
    }
    
    
    
    @IBOutlet var contentImageView: UIImageView!
    
    // MARK: - Properties
    
    var index = 0
    var heading = ""
    var subHeading = ""
    var imageFile = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headingLabel.text = heading
        contentImageView.image = UIImage(named: imageFile)
        let screenSize: CGRect = UIScreen.main.bounds
        contentImageView.frame = CGRect(x: 0, y: 0, width: 50, height: screenSize.height * 0.2)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
