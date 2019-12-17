//
//  UIViewController+Extension.swift
//  Profile
//
//  Created by Gagan Vishal on 2019/12/17.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func registerForKeyboardDidShowNotification(scrollView: UIScrollView, usingBlock block: ((CGSize?) -> Void)? = nil) {
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: nil, using: { (notification) -> Void in
            let userInfo = notification.userInfo!
            let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size
            let contentInsets = UIEdgeInsets.init(top: scrollView.contentInset.top, left: scrollView.contentInset.left, bottom: (keyboardSize.height), right: scrollView.contentInset.right)
            
            scrollView.setContentInsetAndScrollIndicatorInsets(edgeInsets: contentInsets)
            block?(keyboardSize)
        })
    }
    
    func registerForKeyboardWillHideNotification(scrollView: UIScrollView, usingBlock block: (() -> Void)? = nil) {
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil, using: { (notification) -> Void in
            let contentInsets = UIEdgeInsets.init(top: scrollView.contentInset.top, left: scrollView.contentInset.left, bottom: 0, right: scrollView.contentInset.right)
            scrollView.setContentInsetAndScrollIndicatorInsets(edgeInsets: contentInsets)
            block?()
        })
    }
}
