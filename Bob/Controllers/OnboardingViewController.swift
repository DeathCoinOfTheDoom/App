 //
//  OnboardingViewController.swift
//  Bob
//
//  Created by Isabelle Melchiori on 20/03/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, OnboardingPageViewControllerDelegate {
        
        // MARK: - Outlets
        
    @IBOutlet weak var loginButton:
    UIButton!
    
    
    @IBOutlet var pageControl: UIPageControl!
        
        // MARK: - Properties
        
        var onboardingPageViewController: OnboardingPageViewController?
        
        // MARK: - Actions
        
//        @IBAction func skipButtonTapped(sender: UIButton) {
//            UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
//            dismiss(animated: true, completion: nil)
//            
//            let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
//            if let onboardingViewController = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController") as? OnboardingViewController {
//                present(onboardingViewController, animated: true, completion: nil)
//            }
//        }
//        
//        @IBAction func nextButtonTapped(sender: UIButton) {
//            if let index = onboardingPageViewController?.currentIndex {
//                switch index {
//                case 0...4:
//                    onboardingPageViewController?.forwardPage()
//                    
//                case 5:
//                    UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
//                    dismiss(animated: true, completion: nil)
//                    
//                default: break
//                }
//            }
//            
//            updateUI()
//        }
//    
//    
    @IBAction func loginAction(_ sender: Any) {
        
        // TODO: uncomment
        //UserDefaults.standard.set(true, forKey: "hasAlreadySeenOnboarding")
        
        // chargement du fichier Login.storyboard
        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
        
        // Chargement du premier view controller (ici le navigation controller avec la flèche)
        if let loginRootViewController = loginStoryboard.instantiateInitialViewController() {
            self.navigationController?.pushViewController(loginRootViewController, animated: true)
        }
        
    }
    
    @IBAction func signupAction(_ sender: Any) {
        
        // TODO: uncomment
        //UserDefaults.standard.set(true, forKey: "hasAlreadySeenOnboarding")
        // TODO: uncomment
        //UserDefaults.standard.set(true, forKey: "hasAlreadySeenOnboarding")
        
        // chargement du fichier Login.storyboard
        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
        
        // Chargement du premier view controller (ici le navigation controller avec la flèche)
        if let loginRootViewController = loginStoryboard.instantiateInitialViewController() {
            self.navigationController?.pushViewController(loginRootViewController, animated: true)
        }
        

        
    }
    
        func updateUI() {
            if let index = onboardingPageViewController?.currentIndex {
                pageControl.currentPage = index
            }
        }
        
        func didUpdatePageIndex(currentIndex: Int) {
            updateUI()
        }
        
        // MARK: - View controller life cycle
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.navigationController?.isNavigationBarHidden = true
            applyStyles()
            

            // Do any additional setup after loading the view.
            
            // skipButton.addTarget(self, action: #selector(skipButtonTapped(sender:)), for: .touchUpInside)
        }
    
    func applyStyles() {
        loginButton.titleLabel?.font = UIFont(name: Fonts.poppinsRegular, size: 14)
    }
        
        
        
        // MARK: - Navigation
        
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let destination = segue.destination
            if let pageViewController = destination as? OnboardingPageViewController {
                onboardingPageViewController = pageViewController
                onboardingPageViewController?.onboardingDelegate = self
            }
        }
        
        
 }
