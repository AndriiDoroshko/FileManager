//
//  BundleDomainService.swift
//  FileManager
//
//  Created by Andrey Doroshko on 2/6/19.
//  Copyright © 2019 Andrey Doroshko. All rights reserved.
//

import Foundation
import UIKit

class BundleDomainService {
    let mainBundle = Bundle.main
    
    func getAllImages() -> [UIImage] {
        let bundleContetns = try? FileManager.default.contentsOfDirectory(atPath: mainBundle.bundlePath)
        let imagesNames = bundleContetns?.filter { $0.contains("jpeg") }
        
        guard let images = imagesNames?.map({ UIImage(named: $0) }) else {
            return []
        }
        return images.compactMap { $0 }
    }
}
