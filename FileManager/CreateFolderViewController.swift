//
//  CreateFolderViewController.swift
//  FileManager
//
//  Created by Andrey Doroshko on 2/7/19.
//  Copyright © 2019 Andrey Doroshko. All rights reserved.
//

import Foundation
import UIKit

class CreateFolderViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    var currentDirectory: Directories?
    
    let bundleService = BundleDomainService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addButtonTouched(_ sender: Any) {
        guard let directory = currentDirectory else {
            return
        }
        
        let newFolderName = textField.text ?? "New Folder"
        
        do {
            try bundleService.createFolder(named: newFolderName, directory: directory)
        } catch let error {
            print(error)
        }
        self.dismiss(animated: true, completion: nil)
    }
}
