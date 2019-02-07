//
//  PlistsViewController.swift
//  FileManager
//
//  Created by Andrey Doroshko on 2/7/19.
//  Copyright © 2019 Andrey Doroshko. All rights reserved.
//

import Foundation
import UIKit

class PlistsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let bundleService = BundleDomainService()
    var plists = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Plists"
        
        plists = bundleService.getAllPlistNames()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}


extension PlistsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plists.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Default")
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Default")
        }
        
        cell!.textLabel?.text = plists[indexPath.item]
        cell!.accessoryType = .disclosureIndicator
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let viewController = storyboard!.instantiateViewController(withIdentifier: "plistContentViewController") as? PlistContentViewController
        viewController?.displayingPlist = plists[indexPath.item]
        navigationController?.pushViewController(viewController!, animated: true)
    }
}
