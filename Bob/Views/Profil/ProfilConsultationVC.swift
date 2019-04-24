//
//  NameViewController.swift
//  Bob
//
//  Created by Isabelle Melchiori on 30/01/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit

class ProfilConsultationVC: UIViewController {
    
    @IBOutlet weak var birthdayProfilConsultation: UnchangeableInputLabel!
    @IBOutlet weak var emailProfilConsultation: UnchangeableInputLabel!
    @IBOutlet weak var firstNameProfilConsultation: UnchangeableInputLabel!
    
    @IBOutlet weak var lastNameProfilConsultation: UnchangeableInputLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        HeaderBuilderBob.setToken(token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6Ijg2NzI5ZjcwYjgxOGI5MmU2ODVhMzJmMmI2YzY2ODI5MjQ0YjIwNmE2ZDI0MGJlY2QzOTM2YjJjOWNmNDAzMmUzNmY1NjMzYzRiODFhYWE0In0.eyJhdWQiOiIxIiwianRpIjoiODY3MjlmNzBiODE4YjkyZTY4NWEzMmYyYjZjNjY4MjkyNDRiMjA2YTZkMjQwYmVjZDM5MzZiMmM5Y2Y0MDMyZTM2ZjU2MzNjNGI4MWFhYTQiLCJpYXQiOjE1NTQzODExMTIsIm5iZiI6MTU1NDM4MTExMiwiZXhwIjoxNTg2MDAzNTEyLCJzdWIiOiIzMCIsInNjb3BlcyI6W119.HA4CG08yJQsPKwOfhZkyEDQq40efPHHffspNNpUXFnbnOcSrYzUiAg0uXj6WgY44QjlvDugyy63hk02vuYHdNUvkKOioHeLPFm_1ifLvSqnkjC79DMbVBFAzH-FIZYAQdZEEE2pPTcvCO40pVVmS1GAxlhgAujPoxsCy-ZNm3W7DYdg8JUYx83k5VKEDZOB75FKXsSJyX1cd7a4e65BnjfsOYopas0e36iwLp_oa1qHx1jNfA9xuvsMGiUuTps5ols6ok06I7MJaGUirLLw4IoUJLcpBuDdUoAjL32zLTo75e7ePWNRzp1q3LR9Vy0D3PfGPuIHvZDJZiWAGDCvy-S-rhMlzqNh5E68h6tqtGyP1padF0OLad5_n1YKwZ3JR4IK9OBhNzcXXwsuNkcreJIoxhQs_DGHt6J0w4JlQ3XE9HcFvyKD0LfoDFJq9HNgUh3QmDp2KEMjgbZ-eDrPuTd5y2k0dvtkV7B5VK1sF1QNUGIzqplOrkhe3G4K2ko3uUY1dc7elBeuXaxLmJpvraCxWUJleskN60PgvYrAl9A60OSpjM-E5q1r1hVUuYi2fQ-h-qzQrrhAab0AmfGweVzIveSHNEp2T7FtleXReEu1zB80CmtR9u9eKWwAZbR8YxNPYa6NKYxSWpBdfBebyaaHlkDHM1wgYbkOjzWyyF8k")
        UserService.userInfos(query: "user/2", header: HeaderBuilderBob.headers) { (userInfos, e) in
            guard e == nil else {
                print(e!.localizedDescription)
                return
            }

            guard let userInfos = userInfos else {
                print("no result found")
                return
            }
            self.applyDataToView(userInfos: userInfos.attributes)
        }
    }
    func applyDataToView(userInfos: UserInfosAttr) {
        self.lastNameProfilConsultation.text = userInfos.lastName
        self.firstNameProfilConsultation.text = userInfos.firstName
        self.birthdayProfilConsultation.text = userInfos.birthdate
        self.emailProfilConsultation.text = userInfos.email
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        var DestViewController: ProfilUpdateVC = segue.destination as! ProfilUpdateVC
//        DestViewController.birthdayTitleText = self.firstNameProfilConsultation.text
//        
//    }
}
