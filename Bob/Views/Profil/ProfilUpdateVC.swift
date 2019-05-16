//
//  NameViewController.swift
//  Bob
//
//  Created by Isabelle Melchiori on 30/01/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit

class ProfilUpdateVC: UIViewController {
    @IBAction func userButtonModif(_ sender: Any) {
        self.hasModifications()
    }
    @IBOutlet weak var userBirthdayModif: Input!
    @IBOutlet weak var userEmailModif: Input!
    @IBOutlet weak var userFirstNameModif: Input!
    @IBOutlet weak var userLastNameModif: Input!
    var userAttrBeforeModif = UserInfosAttrView(email: "", firstName: "", lastName: "", birthdate: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyDataToView(userInfos: userAttrBeforeModif)
    }
    func sendUserchanges() {
        HeaderBuilderBob.setTokenInHeader()
        let parameters = ["email": userEmailModif.text,"lastName": userLastNameModif.text,"firstName": userFirstNameModif.text,"birthdate": userBirthdayModif.text] as! [String: String]
        let localStorageInstance = LocalStorage()
        let id = localStorageInstance.getUserInfos(key: "id")
        UserService.update(query: "user/\(id)", payload: parameters, header: HeaderBuilderBob.headers) { (userInfos, e) in
            guard e == nil else {
                print(e!.localizedDescription)
                return
            }
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func applyDataToView(userInfos: UserInfosAttrView) {
        userBirthdayModif.text = userInfos.birthdate
        userEmailModif.text = userInfos.email
        userFirstNameModif.text = userInfos.firstName
        userLastNameModif.text = userInfos.lastName
    }
    func hasModifications() {
        if (userAttrBeforeModif.lastName != userLastNameModif.text || userAttrBeforeModif.firstName != userFirstNameModif.text || userAttrBeforeModif.email != userEmailModif.text || userAttrBeforeModif.birthdate != userBirthdayModif.text) {
            print("il y a eu des changements")
            self.sendUserchanges()
        }
        else {
            navigationController?.popToRootViewController(animated: true)
        }
    }
}
