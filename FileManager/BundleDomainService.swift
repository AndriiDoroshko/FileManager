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
    fileprivate let mainBundle = Bundle.main
    fileprivate lazy var bundleContetns = try? FileManager.default.contentsOfDirectory(atPath: mainBundle.bundlePath)
    fileprivate var propertyListForamt =  PropertyListSerialization.PropertyListFormat.xml
    
    
    func getAllImages() -> [UIImage] {
        let imagesNames = bundleContetns?.filter { $0.contains("jpeg") }
        
        guard let images = imagesNames?.map({ UIImage(named: $0) }) else {
            return []
        }
        return images.compactMap { $0 }
    }
    
    func getAllPlistNames() -> [String] {
        guard let plistNames = bundleContetns?.filter ({ $0.contains("plist") }) else { return [] }
        return plistNames.compactMap { $0 }
    }
    
    func getPlistContent(named: String) -> Data {
        let nameAndType = named.components(separatedBy: ".")
        let plistPath = mainBundle.path(forResource: nameAndType[0], ofType: nameAndType[1])!
        return FileManager.default.contents(atPath: plistPath)!
    }
}
