//
//  CameraHandler.swift
//  ImageUpload
//
//  Created by Gagan Vishal on 2019/11/09.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
import UIKit

class CameraHandler: NSObject {
    //shared instance for CameraHandler
    static let shared = CameraHandler()
    fileprivate var currentVC: UIViewController!
    //MARK: Internal Properties
    var imagePickedBlock: ((UIImage) -> Void)?
    
    //MARK:- Access Camera
    func camera()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .camera
            myPickerController.allowsEditing = true
            currentVC.present(myPickerController, animated: true, completion: nil)
        }
    }
    //MARK:- Access library
    func photoLibrary()
    {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .photoLibrary
            myPickerController.allowsEditing = true
            currentVC.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    //MARK:- SHow action to chose photo option
    func showActionSheet(vc: UIViewController) {
        currentVC = vc
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        //camera option
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        }))
        //choose from gallery option
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoLibrary()
        }))
        //cancel option
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        vc.present(actionSheet, animated: true, completion: nil)
    }
}

//MARK:- Image pricker delegate
extension CameraHandler: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        currentVC.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelectedOrCaptured =  info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
             self.imagePickedBlock?(imageSelectedOrCaptured)
            currentVC.dismiss(animated: true, completion: nil)
        }
    }
}

