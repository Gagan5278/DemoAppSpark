//
//  UITextField+Extension.swift
//  Profile
//
//  Created by Gagan Vishal on 2019/12/17.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    struct Attributes {
        static let underlineColor = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0).cgColor
        static let lineWidth = CGFloat(1.0)
        static let rightViewDimension = CGFloat(20.0)
    }
    
    func drawUnderline(withColor color: CGColor, width: CGFloat) {
        let caLayer = CALayer()
        caLayer.borderColor = color
        caLayer.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        caLayer.borderWidth = width
        
        self.layer.addSublayer(caLayer)
        self.layer.masksToBounds = true
    }
}
