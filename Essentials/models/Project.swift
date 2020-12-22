//
//  Project.swift
//  Essentials
//
//  Created by Kilian Hoefman on 22/12/2020.
//

import Foundation

struct Project : Codable {
    public let id: Int
    public let name: String
//    public let changeInitiatives: [ChangeInitiative]        
    
    public enum CodingKeys: String, CodingKey{
        case id = "id"
        case name = "name"
//        case changeInitatives = "changeInitatives"
    }
    
}
