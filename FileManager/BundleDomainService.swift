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
    fileprivate lazy var bundleContetns = try! FileManager.default.contentsOfDirectory(atPath: mainBundle.bundlePath)
    fileprivate let documentDirectoryURL =  try! FileManager.default.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: true)
    fileprivate let applicationSupportDirectoryURL =  try! FileManager.default.url(for: .applicationSupportDirectory, in: .allDomainsMask, appropriateFor: nil, create: true)
    fileprivate let tempDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
    
    func getAllImages() -> [UIImage] {
        let imagesNames = bundleContetns.filter { $0.contains("jpeg") }
        let images = imagesNames.map({ UIImage(named: $0) })
        return images.compactMap { $0 }
    }
    
    func getAllPlistNames() -> [String] {
        let plistNames = bundleContetns.filter ({ $0.contains("plist") })
        return plistNames.compactMap { $0 }
    }
    
    func getPlistContent(named: String) -> Data {
        let nameAndType = named.components(separatedBy: ".")
        let plistPath = mainBundle.path(forResource: nameAndType[0], ofType: nameAndType[1])!
        return FileManager.default.contents(atPath: plistPath)!
    }
    
    func contentsOfDirectory(directory: Directories) throws -> [URL] {
        let directoryURL: URL
        switch directory {
        case .documents:
            directoryURL = documentDirectoryURL
        case .applicationSupport:
            directoryURL = applicationSupportDirectoryURL
        case .temp:
            directoryURL = tempDirectoryURL
        }
        
        return try FileManager.default.contentsOfDirectory(at: directoryURL,
                                                            includingPropertiesForKeys: nil,
                                                            options: [])
    }
    
    func contentOfURL(url: URL) throws -> [URL] {
       return try FileManager.default.contentsOfDirectory(at: url,
                                                          includingPropertiesForKeys: nil,
                                                          options: [])
    }
    
    func createFolder(named: String, directory: Directories) throws {
        let directoryURL: URL
        switch directory {
        case .documents:
            directoryURL = documentDirectoryURL
        case .applicationSupport:
            directoryURL = applicationSupportDirectoryURL
        case .temp:
            directoryURL = tempDirectoryURL
        }
        try FileManager.default.createDirectory(at: directoryURL.appendingPathComponent(named), withIntermediateDirectories: false, attributes: nil)
    }
    
    func deleteFolder(named: String, directory: Directories) throws {
        let directoryURL: URL
        switch directory {
        case .documents:
            directoryURL = documentDirectoryURL
        case .applicationSupport:
            directoryURL = applicationSupportDirectoryURL
        case .temp:
            directoryURL = tempDirectoryURL
        }
        try FileManager.default.removeItem(at: directoryURL.appendingPathComponent(named))
       // createDirectory(at: directoryURL.appendingPathComponent(named), withIntermediateDirectories: false, attributes: nil)
    }
}

enum Directories {
    case documents, temp, applicationSupport
}
