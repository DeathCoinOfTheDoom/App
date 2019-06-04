//
//  NameViewController.swift
//  Bob
//
//  Created by Isabelle Melchiori on 30/01/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit

class ProfilUpdateVC: KeyboardController {
    @IBAction func userButtonModif(_ sender: Any) {
        self.hasModifications()
    }
    @IBOutlet weak var userBirthdayModif: Input!
    @IBOutlet weak var userEmailModif: Input!
    @IBOutlet weak var userFirstNameModif: Input!
    @IBOutlet weak var userLastNameModif: Input!
    
    var userAttrBeforeModif = UserInfosAttrView(email: "", firstName: "", lastName: "", birthdate: "", phoneNumber: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyDataToView(userInfos: userAttrBeforeModif)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func sendUserchanges() {
        HeaderBuilderBob.setTokenInHeader()
        print("userAttrBeforeModif", userAttrBeforeModif)
        let parameters = ["phone_number": userAttrBeforeModif.phoneNumber,
                          "email": userEmailModif.text!,
                          "lastName": userLastNameModif.text!,
                          "firstName": userFirstNameModif.text!,
                          "birthdate": userBirthdayModif.text!,
                          "_method": "put"]
        let localStorageInstance = LocalStorage()
        let id = localStorageInstance.getUserInfos(key: "id")
        UserService.postUserInfos(query: "user/\(id)", payload: parameters, header: HeaderBuilderBob.headers) { (userInfos, e) in
            guard e == nil else {
                print(e!.localizedDescription)
                return
            }
            let nextVC = self.navigationController?.viewControllers[0] as! ProfilConsultationVC
            if let userInfos = userInfos {
                let userAttr = userInfos.data.attributes
                nextVC.userInfos = UserInfosAttrView(email: userAttr.email, firstName: userAttr.firstName, lastName: userAttr.lastName, birthdate: userAttr.birthdate, phoneNumber: userAttr.phoneNumber)
                nextVC.applyDataToView(userInfos: userAttr)
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
