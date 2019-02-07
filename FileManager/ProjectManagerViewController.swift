//
//  ProjectManagerViewController.swift
//  FileManager
//
//  Created by Andrey Doroshko on 2/7/19.
//  Copyright © 2019 Andrey Doroshko. All rights reserved.
//

import Foundation
import UIKit

class ProjectManagerViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let bundleService = BundleDomainService()
    var content: [ProjectManagerDomainModel]?
    var displayingPlist = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = bundleService.getPlistContent(named: displayingPlist)
        let decoder = PropertyListDecoder()
        content = try? decoder.decode([ProjectManagerDomainModel].self, from: data)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ProjectManagerViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Subtitle")
        if (cell == nil) {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Subtitle")
        }
        
        cell!.textLabel?.text = content?[indexPath.item].firstName
        cell!.detailTextLabel?.text = content?[indexPath.item].lastName
        cell!.accessoryType = .disclosureIndicator
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let viewController = storyboard!.instantiateViewController(withIdentifier: "projectsViewController") as? ProjectsViewController
        viewController?.projects = content?[indexPath.item].projects
        navigationController?.pushViewController(viewController!, animated: true)
    }
}


