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
    var images = [UIImage]() 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        images = bundleService.getAllImages()
    }
    
    @objc func tap(_ sender: AnyObject) {
        guard let imageView = sender.view! as? UIImageView else { return }
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        print("sender.view.tag")
    }
    
    @objc func dismissFullscreenImage(_ sender: AnyObject) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
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
        
        collectionViewCell.imageView.tag = indexPath.row
        collectionViewCell.imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        collectionViewCell.imageView.isUserInteractionEnabled = true
        
        return collectionViewCell
    }
}
