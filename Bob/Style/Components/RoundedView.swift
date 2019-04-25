//
//  RoundedIcon.swift
//  Bob
//
//  Created by Gérome Lacaux on 05/04/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func rounded() {
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
}
