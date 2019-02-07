//
//  DevelopersViewController.swift
//  FileManager
//
//  Created by Andrey Doroshko on 2/7/19.
//  Copyright © 2019 Andrey Doroshko. All rights reserved.
//

import Foundation
import UIKit

class DevelopersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var displayingPlistName = ""
    var developers: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = displayingPlistName
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension DevelopersViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return developers?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Default")
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Dubtitle")
        }
        
        cell!.textLabel?.text = developers?[indexPath.item] ?? "Nothing to display"
        cell!.accessoryType = .none
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
