//
//  ChangeInitiative.swift
//  Essentials
//
//  Created by Ziggy Moens on 21/12/2020.
//

import Foundation

struct ChangeInitiative {
    
    let id: Int
    var title: String
    var description: String
    var startDate: String
    var endDate: String
    var changeGroup: [ChangeGroup]
    var changeSponsor: Employee?
    var roadMaps: [String]
    var progress: String
    
    init?(id: Int, title: String, description: String, startDate: String, endDate: String, changeGroup: [ChangeGroup]?, changesponsor: Employee?, roadmaps: [String], progress: String) {
        if id < 0 || title.isEmpty || description.isEmpty || startDate.isEmpty || endDate.isEmpty || roadmaps.isEmpty || progress.isEmpty {
            return nil
        }
        self.id = id
        self.title = title
        self.description = description
        self.startDate = startDate
        self.endDate = endDate
        self.changeGroup = changeGroup ?? [ChangeGroup]()
        self.changeSponsor = changesponsor
        self.roadMaps = roadmaps
        self.progress = progress
    }
    
}
