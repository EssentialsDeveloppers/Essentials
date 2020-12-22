//
//  Organization.swift
//  Essentials
//
//  Created by Kilian Hoefman on 22/12/2020.
//

import Foundation

class Organization : Codable {
    var id: Int
    var name: String
//    var employees: [Employee]
//    var changeManagers: [ChangeManager]
    var portfolio: Portfolio
    
    init?(id: Int, name: String/*, employees: [Employee], changeManagers: [ChangeManager]*/, portfolio: Portfolio) {
        if id < 0 || name.isEmpty {
            return nil
        }
        self.id = id
        self.name = name
//        self.employees = employees
//        self.changeManagers = changeManagers
        self.portfolio = portfolio
    }
    
    public enum CodingKeys: String, CodingKey{
        case id = "id"
        case name = "name"
//        case employees = "employees"
//        case changeManagers = "changeManagers"
        case portfolio = "portfolio"
    }
}
