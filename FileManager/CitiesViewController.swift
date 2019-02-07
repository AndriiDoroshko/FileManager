//
//  CitiesViewController.swift
//  FileManager
//
//  Created by Andrey Doroshko on 2/7/19.
//  Copyright © 2019 Andrey Doroshko. All rights reserved.
//

import Foundation
import UIKit

class CitiesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let bundleService = BundleDomainService()
    var displayingPlist = ""
    var content: CountiesDomainModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension CitiesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content?.cities.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Default")
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Default")
        }
        
        cell!.textLabel?.text = content?.cities[indexPath.item] ?? "Nothing to display"
        cell!.accessoryType = .disclosureIndicator
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

