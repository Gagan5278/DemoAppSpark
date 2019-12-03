//
//  ImageStore.swift
//  ImageUpload
//
//  Created by Gagan Vishal on 2019/11/09.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
import UIKit
class ImageStore {
    class func getAllImageFromDocumentDirectory(completionHandler:@escaping ([ImageModel]?) -> Void) {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        do {
            var imageModels: [ImageModel] = [ImageModel]()
            let allContents = try FileManager.default.contentsOfDirectory(atPath: path!)
            for path in allContents {
                if let image =  UIImage.getSavedImageFromDocumentDirectory(with: path) {
                    imageModels.append(ImageModel(image: image))
                }
            }
            completionHandler(!imageModels.isEmpty ? imageModels : nil)
        }
        catch {
            completionHandler(nil)
        }
    }
}

