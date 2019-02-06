//
//  MainScreenTableViewModel.swift
//  FileManager
//
//  Created by Andrey Doroshko on 2/6/19.
//  Copyright © 2019 Andrey Doroshko. All rights reserved.
//

import Foundation

struct MainScreenTableViewModel {
    let sections: [Section]
    
    init() {
        sections = [Section(type: .bundle),
                    Section(type: .fileManager)]
    }
    
    struct Section {
        let cell: [Cell]
        let type: SectionType
        
        init(type: SectionType) {
            self.type = type
            switch type {
            case .bundle:
                self.cell = [.images, .plists]
            case .fileManager:
                self.cell = [.temp, .documents, .applicationSupport]
            }
        }
        
        enum SectionType: String {
            case bundle = "NSBUNDLE"
            case fileManager = "NSFILEMANAGER"
        }
        
        enum Cell: String {
            case images = "Images"
            case plists = "Plists"
            case temp = "Temp"
            case applicationSupport = "Application Support"
            case documents = "Documents"
        }
    }
}
