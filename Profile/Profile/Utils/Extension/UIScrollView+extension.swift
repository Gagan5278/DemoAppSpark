//
//  UIScrollView+extension.swift
//  Profile
//
//  Created by Gagan Vishal on 2019/12/17.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    func setContentInsetAndScrollIndicatorInsets(edgeInsets: UIEdgeInsets) {
        self.contentInset = edgeInsets
        self.scrollIndicatorInsets = edgeInsets
    }
}
