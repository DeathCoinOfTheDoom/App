//
//  OnboardingPageViewController.swift
//  Bob
//
//  Created by Isabelle Melchiori on 20/03/2019.
//  Copyright © 2019 Bob. All rights reserved.
//


import UIKit

protocol OnboardingPageViewControllerDelegate: class {
    func didUpdatePageIndex(currentIndex: Int)
}

class OnboardingPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    // MARK: - Properties
    
    weak var onboardingDelegate: OnboardingPageViewControllerDelegate?
    
    var pageHeadings = ["STEP 1", "STEP 2", "STEP 3", "STEP 4", "STEP 5", "STEP 6"]
    var pageImages = ["onboarding-1", "onboarding-2", "onboarding-3", "onboarding-4", "onboarding-5", "onboarding-6"]
    var pageSubHeadings = ["Bob le portefeuille sécurisé de vos documents", "Qui vous guide et accompagne ", "Expliquez les catégories (Ajoutez vos documents...)", "Expliquez la creation de dossier (En quelques cliques Bob vous guide afin de créer votre dossier...)", "Envoi du dossier (Envoyez vos dossiers simplement)", "Commencez maintenant"]
    
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the data source and the delegate to itself
        dataSource = self
        delegate = self
        
        // Create the first walkthrough screen
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! OnboardingContentViewController).index
        index -= 1
        
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! OnboardingContentViewController).index
        index += 1
        
        return contentViewController(at: index)
    }
    
    // MARK: - Helper
    
    func contentViewController(at index: Int) -> OnboardingContentViewController? {
        if index < 0 || index >= pageHeadings.count {
            return nil
        }
        
        // Create a new view controller and pass suitable data
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let pageContentViewController = storyboard.instantiateViewController(withIdentifier: "OnboardingContentViewController") as? OnboardingContentViewController {
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.subHeading = pageSubHeadings[index]
            pageContentViewController.index = index
            
            return pageContentViewController
        }
        
        return nil
    }
    
    func forwardPage() {
        currentIndex += 1
        if let nextViewController = contentViewController(at: currentIndex) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: - Page View Controller delegate
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let contentViewController = pageViewController.viewControllers?.first as? OnboardingContentViewController {
                currentIndex = contentViewController.index
                
                onboardingDelegate?.didUpdatePageIndex(currentIndex: currentIndex)
            }
        }
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
