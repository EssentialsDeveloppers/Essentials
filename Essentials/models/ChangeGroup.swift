//
//  ChangeGroup.swift
//  Essentials
//
//  Created by Jonathan Vanden Eynden on 21/12/2020.
//

import Foundation

struct ChangeGroup : Codable {
    public let id : Int
    public let name : String
    public let employeeChangeGroups : [EmployeeChangeGroup]?
    
    public enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case employeeChangeGroups = "employeeChangeGroups"
    }
}


