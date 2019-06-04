import UIKit

class OnboardingVC: UIViewController, OnboardingPageVCDelegate {
        
    // MARK: - Outlets
    @IBOutlet weak var loginButton:
    UIButton!
    @IBOutlet var pageControl: UIPageControl!
    
    // MARK: - Properties
        
    var onboardingPageViewController: OnboardingPageVC?
        
    // MARK: - Actions
    @IBAction func loginAction(_ sender: Any) {
    // Already known user
    //UserDefaults.standard.set(true, forKey: "hasAlreadySeenOnboarding")
    // chargement du fichier Login.storyboard
        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
        if let loginRootViewController = loginStoryboard.instantiateInitialViewController() {
            self.navigationController?.pushViewController(loginRootViewController, animated: true)
        }
    }
    
    @IBAction func signupAction(_ sender: Any) {
        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
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
    }
    func applyStyles() {
        loginButton.titleLabel?.font = UIFont(name: Fonts.poppinsRegular, size: 14)
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageViewController = destination as? OnboardingPageVC {
            onboardingPageViewController = pageViewController
            onboardingPageViewController?.onboardingDelegate = self
        }
    }
 }
