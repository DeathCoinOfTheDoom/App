import Foundation
import UIKit

func applyTabbarItems(self: UIViewController) {
    self.tabBarController?.tabBar.items?[0].title = "Accueil"
    self.tabBarController?.tabBar.items?[1].title = "Mes dossiers"
    self.tabBarController?.tabBar.items?[1].image = UIImage(named: "icon-folder")
    self.tabBarController?.tabBar.items?[2].title = "Profil"
    self.tabBarController?.tabBar.items?[2].image = UIImage(named: "icon-profile")
}
