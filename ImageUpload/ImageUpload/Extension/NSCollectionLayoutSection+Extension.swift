//
//  NSCollectionLayoutSection.swift
//  ImageUpload
//
//  Created by Gagan Vishal on 2019/11/09.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
import UIKit

extension NSCollectionLayoutSection {
    //MARK:- Grid layout for Images
    static func gridLayput(envoirnment: NSCollectionLayoutEnvironment, height: NSCollectionLayoutDimension, compactItems: Int, regularItems: Int ) -> NSCollectionLayoutSection {
        //1. Item size
        let itemsCount: Int = envoirnment.traitCollection.horizontalSizeClass == .compact ? compactItems : regularItems
        let itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/CGFloat(itemsCount)), heightDimension: .fractionalHeight(1.0))
        //2. Section Item
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //2. Group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: height), subitem: item, count: itemsCount)
        //3.
        return NSCollectionLayoutSection(group: group)
    }
}
