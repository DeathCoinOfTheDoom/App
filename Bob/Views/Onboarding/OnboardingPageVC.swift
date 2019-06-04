//
//  OnboardingPageViewController.swift
//  Bob
//
//  Created by Isabelle Melchiori on 20/03/2019.
//  Copyright © 2019 Bob. All rights reserved.
//


import UIKit

protocol OnboardingPageVCDelegate: class {
    func didUpdatePageIndex(currentIndex: Int)
}

class OnboardingPageVC: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    // MARK: - Properties
    
    weak var onboardingDelegate: OnboardingPageVCDelegate?
    var pageHeadings = ["Bob est un portefeuille sécurisé pour les documents liés à vos demandes de locations.", "Bob vous accompagne lors la constitutions de vos dossiers locatifs.", "Afin de vous organiser, plusieurs catégories sont à votre disposition pour stocker vos documents.", "Constituez ensuite vos dossiers locatifs, en choisissant les documents à y intégrer.", "D’un simple geste, envoyez votre dossier pour vous démarquez des autres candidats.", "On y va ? C’est parti !"]
    var pageImages = ["onboarding1", "onboarding2", "onboarding3", "onboarding4", "onboarding5", "onboarding6"]
    
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
        var index = (viewController as! OnboardingContentVC).index
        index -= 1
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! OnboardingContentVC).index
        index += 1
        return contentViewController(at: index)
    }
    
    // MARK: - Helper
    func contentViewController(at index: Int) -> OnboardingContentVC? {
        if index < 0 || index >= pageHeadings.count {
            return nil
        }
        // Create a new view controller and pass suitable data
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let pageContentViewController = storyboard.instantiateViewController(withIdentifier: "OnboardingContentViewController") as? OnboardingContentVC {
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
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
            if let contentViewController = pageViewController.viewControllers?.first as? OnboardingContentVC {
                currentIndex = contentViewController.index
                
                onboardingDelegate?.didUpdatePageIndex(currentIndex: currentIndex)
            }
        }
    }
}
