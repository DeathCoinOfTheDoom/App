//
//  OnboardingContentViewController.swift
//  Bob
//
//  Created by Isabelle Melchiori on 19/03/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit

class OnboardingContentViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var headingLabel: UILabel! {
        didSet {
            headingLabel.numberOfLines = 2
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
