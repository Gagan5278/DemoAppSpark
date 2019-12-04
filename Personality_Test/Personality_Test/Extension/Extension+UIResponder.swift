//
//  Extension+UIResponder.swift
//  Personality_Test
//
//  Created by Gagan Vishal on 2019/12/04.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
import UIKit

extension UIResponder {
    //get top parentview controller object from a view
    @objc func getParentViewController() -> UIViewController? {
        if self.next is UIViewController {
            return self.next as? UIViewController
        } else {
            if self.next != nil {
                return (self.next!).getParentViewController()
            }
            else {return nil}
        }
    }
}
