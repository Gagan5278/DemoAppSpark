//
//  UIImage+Extensions.swift
//  ImageUpload
//
//  Created by Gagan Vishal on 2019/11/09.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    // MARK:- Get image from document directory
    static func getSavedImageFromDocumentDirectory(with name: String) -> Self? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return (UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(name).path) as! Self)
        }
        return nil
    }
    
    //MARK:- Save photo in document directory
    func saveImageInDocumentDirecoty(with imageName: String, completionHandler: (Bool) -> Void) {
        var isPhotoSaved: Bool = false
        guard let data = self.jpegData(compressionQuality: 1) ?? self.pngData() else {
            completionHandler(isPhotoSaved)
            return
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            completionHandler(isPhotoSaved)
            return
        }
        do {
            try data.write(to: directory.appendingPathComponent(imageName)!)
            isPhotoSaved = true
        } catch {
            isPhotoSaved = false
        }
        completionHandler(isPhotoSaved)
    }
    
    //MARK:- Thumbnail images
    func resizeImageWith(newSize: CGSize) -> UIImage {
        let horizontalRatio = newSize.width / size.width
        let verticalRatio = newSize.height / size.height
        let ratio = max(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
