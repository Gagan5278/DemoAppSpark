//
//  ViewController.swift
//  ImageUpload
//
//  Created by Gagan Vishal on 2019/11/09.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import UIKit

class UserImageViewController: UIViewController {
    //IBOultes
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    private lazy var dataSource = makeDataSource()
    var imageList: ImageList?
    var cellIDString: String {
        return String(describing: ImageCollectionViewCell.self)
    }
    //MARK:- ViewController DataSource
    override func viewDidLoad() {
        imageCollectionView.register(UINib(nibName:self.cellIDString , bundle: .main), forCellWithReuseIdentifier: self.cellIDString)
        imageCollectionView.collectionViewLayout =  UICollectionViewCompositionalLayout(sectionProvider: sectionLayout(for:enoironment:) )
        imageCollectionView.delegate = self
        ImageStore.getAllImageFromDocumentDirectory { [weak self](imageModels) in
            if let models = imageModels {
                self?.imageList = ImageList(images: models)
                self?.updateWith(image: self!.imageList!, animated: true)
            }
        }
    }


    //MARK:- Tap on imageview
    @IBAction func changeImageViewTapped(_ sender: Any) {
        //1. Show Action sheet for camera
        CameraHandler.shared.showActionSheet(vc: self)
        //2. ImagePicker block
        CameraHandler.shared.imagePickedBlock = {  (imageSelected) in
            let imageName = "\(Int(Date().timeIntervalSince1970))"
            imageSelected.saveImageInDocumentDirecoty(with: imageName, completionHandler: { (isSaved) in
                print("Images Saved :\(isSaved)")
                self.imageList!.images.append(ImageModel(image: imageSelected))
                self.updateWith(image: self.imageList!, animated: true)

            })
        }
    }
    
    //MARK: Layout
    private func sectionLayout(for sectionIndex: Int, enoironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        return NSCollectionLayoutSection.gridLayput(envoirnment: enoironment, height: .absolute(200.0), compactItems: 2, regularItems: 5)
    }
}

extension UserImageViewController {
    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, ImageModel> {
        let identifier = self.cellIDString
        return UICollectionViewDiffableDataSource(collectionView: self.imageCollectionView) { collectionView, indexPath, image in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? ImageCollectionViewCell
            cell?.userImageView.image = image.image
            return cell
        }
    }
}


extension UserImageViewController {
    func updateWith(image list: ImageList, animated: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ImageModel> ()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(list.images, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: animated, completion: nil)
    }
    
    func delete(image: ImageList, animated: Bool = true){
        var snapshot = NSDiffableDataSourceSnapshot<Section, ImageModel>()
        snapshot.deleteItems(image.images)
        dataSource.apply(snapshot)
    }
}

extension UserImageViewController {
    enum Section: CaseIterable {
        case main
    }
}

//MARK:- UICollectionViewDelegate
extension UserImageViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {

            return 2
    }
}
