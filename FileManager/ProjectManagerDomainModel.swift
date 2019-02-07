//
//  ProjectManagerDomainModel.swift
//  FileManager
//
//  Created by Andrey Doroshko on 2/7/19.
//  Copyright © 2019 Andrey Doroshko. All rights reserved.
//

import Foundation

struct ProjectManagerDomainModel: Codable {
    let firstName: String
    let lastName: String
    
    let projects: [Project]
    
    struct Project: Codable {
        let projectName: String
        let developers: [String]
    }
}
