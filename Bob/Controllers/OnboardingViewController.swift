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
        
        @IBOutlet var pageControl: UIPageControl!
        
        @IBOutlet var nextButton: UIButton! {
            didSet {
                nextButton.layer.cornerRadius = 25.0
                nextButton.layer.masksToBounds = true
            }
        }
        
        @IBOutlet var skipButton: UIButton!
        
        // MARK: - Properties
        
        var onboardingPageViewController: OnboardingPageViewController?
        
        // MARK: - Actions
        
        @IBAction func skipButtonTapped(sender: UIButton) {
            UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
            dismiss(animated: true, completion: nil)
        }
        
        @IBAction func nextButtonTapped(sender: UIButton) {
            if let index = onboardingPageViewController?.currentIndex {
                switch index {
                case 0...4:
                    onboardingPageViewController?.forwardPage()
                    
                case 5:
                    UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
                    dismiss(animated: true, completion: nil)
                    
                default: break
                }
            }
            
            updateUI()
        }
        
        func updateUI() {
            if let index = onboardingPageViewController?.currentIndex {
                switch index {
                case 0...4:
                    nextButton.setTitle("NEXT", for: .normal)
                    skipButton.isHidden = false
                    
                case 5:
                    nextButton.setTitle("GET STARTED", for: .normal)
                    skipButton.isHidden = true
                    
                default: break
                }
                
                pageControl.currentPage = index
            }
        }
        
        func didUpdatePageIndex(currentIndex: Int) {
            updateUI()
        }
        
        // MARK: - View controller life cycle
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Do any additional setup after loading the view.
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
