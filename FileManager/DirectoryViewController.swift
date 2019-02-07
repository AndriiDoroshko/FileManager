//
//  DirectoryViewController.swift
//  FileManager
//
//  Created by Andrey Doroshko on 2/7/19.
//  Copyright © 2019 Andrey Doroshko. All rights reserved.
//

import Foundation
import UIKit

class DirectoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let bundleService = BundleDomainService()
    var currentDirectory: Directories?
    var contains: [URL]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contains = try? bundleService.contentsOfDirectory(directory: currentDirectory!)
        tableView.delegate = self
        tableView.dataSource = self
        setUpNavigationItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contains = try? bundleService.contentsOfDirectory(directory: currentDirectory!)
    }
    
    func setUpNavigationItems() {
        let addFolder = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFolder(_:)))
        navigationItem.setRightBarButton(addFolder, animated: true)
    }
    
    @objc func addFolder(_: AnyObject) {
        let viewController = storyboard!.instantiateViewController(withIdentifier: "createFolderViewController") as? CreateFolderViewController
        viewController?.currentDirectory = currentDirectory
        navigationController?.present(viewController!, animated: true, completion: nil)
    }
}

extension DirectoryViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contains?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Subtitle")
        if (cell == nil) {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Subtitle")
        }
        
        cell!.textLabel?.text = contains?[indexPath.item].lastPathComponent
        cell!.detailTextLabel?.text = "folder"
        cell!.accessoryType = .disclosureIndicator
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            do {
                try bundleService.deleteFolder(named: contains![indexPath.item].lastPathComponent, directory: currentDirectory!)
                contains?.remove(at: indexPath.item)
            } catch let error {
                print(error)
            }
        }
        
    }
}

