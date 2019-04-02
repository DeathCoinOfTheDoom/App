//
//  FolderCreationViewController.swift
//  Bob
//
//  Created by Isabelle Melchiori on 02/04/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit

class FolderCreationViewController: UIViewController {

    lazy var userFolders = [UserFolder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HeaderBuilderBob.setToken(token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImI3NmI1YmQzZjg5ZjA0YWNiMzczODg1YTk0ZjdhNzQ2YjZlODdiNDVlODE4YzY4YWE1ZGUxYzA5NTk1MjA3Mjc2Yzk4MTBlYTg5ZTZiMmQwIn0.eyJhdWQiOiIxIiwianRpIjoiYjc2YjViZDNmODlmMDRhY2IzNzM4ODVhOTRmN2E3NDZiNmU4N2I0NWU4MThjNjhhYTVkZTFjMDk1OTUyMDcyNzZjOTgxMGVhODllNmIyZDAiLCJpYXQiOjE1NTQyMDg4OTIsIm5iZiI6MTU1NDIwODg5MiwiZXhwIjoxNTg1ODMxMjkyLCJzdWIiOiIzMCIsInNjb3BlcyI6W119.hT90XOHWTZUMsA-g4dOwUBMhF-gLYw0e9-zEeWWZQ6a7GDKMiViyN4XnXzl71SMbSCxhPEiymgxMFA9od91SyYcuAVBM308GaV3-SdI8hKWoUU5suGvS8og4dORwN2g6_wd8GFto5-qjV73-isjbg6Nel2AsMD9lVNpzrYtJFqzqbCPEwjkZtHq1kx5J3tKPLBDKzs8lRl4Vlw-bqGwrFuS34UMNiGr8u1I9sNaGnYskFABRndwc2grhNSUF1LOkjsHmVT719hnfIyE8OeKzToB6xIRrqRwgRNVKZUazpYYJB3mkFHh20QjnZ2e-M6SMZffM9-wGjvEWiYGb_Ee9GSyZZPf1X0219v21KkCIL2ugKpVPMaqPjhR3J67MDIS6k0pPaixmIENm45mLed_U_GTF8RgwSPYBUISzrIY5qB1YC-4hddAiVZLSG0_e0aXb__4YnqiNZS9_fsGZ2tUXS0BbHcqlrvq6s5nlkd5XNJTtzk9D31LbT8xn2CWAGNzW2c3Sivb-w-v1UVPOF-TNO_0WSOy4CyzvcMxSMaUkGA6RFHCOX5iKQI3IkqOSxd1w_p4l62UKgXMDFofpdC9zhlWSaGfe1LNfKDTN_wQXICoKBf86miDRzkjmDecHAvVS4zE5is7uYZstAPvW7YkA4gIhZhyT6idzpwHOG2ZdT2M")
        UserService.folders(query: "user/2/folder", header: HeaderBuilderBob.headers) { (test, e) in
            print("yo",test)
        }
        // Do any additional setup after loading the view.
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
