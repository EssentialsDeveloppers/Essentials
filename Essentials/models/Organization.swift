//
//  Organization.swift
//  Essentials
//
//  Created by Kilian Hoefman on 22/12/2020.
//

import Foundation

struct Organization : Codable {
    public let id: Int
    public let name: String
    public let employees: [Employee]?
    public let changeManagers: [ChangeManager]
    public let portfolio: Portfolio?
    
    public enum CodingKeys: String, CodingKey{
        case id = "id"
        case name = "name"
        case employees = "employees"
        case changeManagers = "changeManagers"
        case portfolio = "portfolio"
    }
}
