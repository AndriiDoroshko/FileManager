//
//  CountiesDomainModel.swift
//  FileManager
//
//  Created by Andrey Doroshko on 2/7/19.
//  Copyright © 2019 Andrey Doroshko. All rights reserved.
//

import Foundation

struct CountiesDomainModel: Codable {
    let name: String
    let cities: [String]
}
