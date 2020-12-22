//
//  Portfolio.swift
//  Essentials
//
//  Created by Kilian Hoefman on 22/12/2020.
//

import Foundation

class Portfolio : Codable {
    var id: Int
    var projects: [Project]
    
    init?(id: Int, projects: [Project]){
        if id < 0 {
            return nil
        }
        self.id = id
        self.projects = projects
    }
    
    public enum CodingKeys: String, CodingKey{
        case id = "id"
        case projects = "projects"
    }
}
