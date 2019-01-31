//
//  BirthdayViewController.swift
//  Bob
//
//  Created by Isabelle Melchiori on 30/01/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit

class BirthdayViewController: UIViewController {

    @IBOutlet weak var BirthdayPicker: UITextField!
    @IBOutlet weak var BirthdayTitle: TitleLabel!

    var birthdayTitleText = String()
    
    lazy var formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        BirthdayTitle.text = "Quelle est votre date de naissance \(birthdayTitleText) ?"
        
        let birthdayPicker = UIDatePicker()
        birthdayPicker.datePickerMode = UIDatePicker.Mode.date
        birthdayPicker.locale = Locale(identifier: "fr_FR")
        birthdayPicker.addTarget(self, action: #selector(BirthdayViewController.birthdayPickerValueChange(sender: )), for: UIControl.Event.valueChanged)
        
        BirthdayPicker.inputView = birthdayPicker
    }
    
    @objc func birthdayPickerValueChange(sender: UIDatePicker) {
        formatter.dateStyle = DateFormatter.Style.long
        formatter.timeStyle = DateFormatter.Style.none
        formatter.locale = Locale(identifier: "fr_FR")
        BirthdayPicker.text = formatter.string(from: sender.date)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
