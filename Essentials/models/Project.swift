//
//  Project.swift
//  Essentials
//
//  Created by Kilian Hoefman on 22/12/2020.
//

import Foundation

class Project : Codable {
    var id: Int
    var name: String
//    var changeInitiatives: [ChangeInitiative]
    
    init?(id: Int, name: String/*, changeInitiatives: [ChangeInitative]*/) {
        if id < 0 || name.isEmpty {
            return nil
        }
        self.id = id
        self.name = name
//        self.changeInitiatives = changeInitiatives
    }
    
    public enum CodingKeys: String, CodingKey{
        case id = "id"
        case name = "name"
//        case changeInitatives = "changeInitatives"
    }
    
}
