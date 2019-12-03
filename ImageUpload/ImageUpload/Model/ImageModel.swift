//
//  ImageModel.swift
//  ImageUpload
//
//  Created by Gagan Vishal on 2019/11/09.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
import UIKit

struct ImageModel: Hashable {
    let identifier: UUID = UUID()
    let image: UIImage //image name is timestamp when image was stored in document directory
    func hash(into hasher: inout Hasher){
        return hasher.combine(identifier)
    }
    
    static func == (lhs:ImageModel, rhs: ImageModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

struct ImageList {
    var images: [ImageModel]
}
