import UIKit

class AppInit: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func dispatchView() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if (TokenHelper().getToken(key: "token") == "") {
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ConnectionNVC") as! UINavigationController
            self.present(nextViewController, animated:true, completion:nil)
        }
        else {
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainTBVC") as! UINavigationController
            self.present(nextViewController, animated:true, completion:nil)
        }
    }
}
