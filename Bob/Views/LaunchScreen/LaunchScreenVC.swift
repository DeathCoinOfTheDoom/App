//
//  LaunchScreen.swift
//  Bob
//
//  Created by Gérome Lacaux on 30/01/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit

class LaunchScreenVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hasAlreadySeenOnboarding = UserDefaults.standard.bool(forKey: "hasAlreadySeenOnboarding")
        
        if !hasAlreadySeenOnboarding {
            let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
            let onboardingViewController = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController")
                present(onboardingViewController, animated: true, completion: nil)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
}
