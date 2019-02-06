//
//  CollectionViewCell.swift
//  FileManager
//
//  Created by Andrey Doroshko on 2/6/19.
//  Copyright © 2019 Andrey Doroshko. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    
    func displayImage(_ image: UIImage) {
        imageView.image = image
//        imageView.addGestureRecognizer(<#T##gestureRecognizer: UIGestureRecognizer##UIGestureRecognizer#>)
    }
}
