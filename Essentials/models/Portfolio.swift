//
//  Portfolio.swift
//  Essentials
//
//  Created by Kilian Hoefman on 22/12/2020.
//

import Foundation

struct Portfolio : Codable {
    public let id: Int
    public let projects: [Project]
    
    public enum CodingKeys: String, CodingKey{
        case id = "id"
        case projects = "projects"
    }
}
