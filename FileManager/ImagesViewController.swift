//
//  ImagesViewController.swift
//  FileManager
//
//  Created by Andrey Doroshko on 2/6/19.
//  Copyright © 2019 Andrey Doroshko. All rights reserved.
//

import Foundation
import UIKit

class ImagesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let bundleService = BundleDomainService()
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ImagesViewController.tap(_:)))
    var images = [UIImage]() 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        images = bundleService.getAllImages()
    }
    
    @objc func tap(_ sender: AnyObject) {
        print(sender.view.tag)
    }
}

extension ImagesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath)
        guard let collectionViewCell = cell as? CollectionViewCell else { return cell }
        collectionViewCell.displayImage(images[indexPath.item])
        
        collectionViewCell.imageView.isUserInteractionEnabled = true
        collectionViewCell.imageView.tag = indexPath.row
        collectionViewCell.imageView.addGestureRecognizer(tapGestureRecognizer)
        
        return collectionViewCell
    }
}
