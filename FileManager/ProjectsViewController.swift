//
//  ProjectsViewController.swift
//  FileManager
//
//  Created by Andrey Doroshko on 2/7/19.
//  Copyright © 2019 Andrey Doroshko. All rights reserved.
//

import Foundation
import UIKit

class ProjectsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var projects: [ProjectManagerDomainModel.Project]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ProjectsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Default")
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Dubtitle")
        }
        
        cell!.textLabel?.text = projects?[indexPath.item].projectName
        cell!.accessoryType = .disclosureIndicator
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let viewController = storyboard!.instantiateViewController(withIdentifier: "developersViewController") as? DevelopersViewController
        viewController?.developers = projects?[indexPath.item].developers
        navigationController?.pushViewController(viewController!, animated: true)
    }
}
