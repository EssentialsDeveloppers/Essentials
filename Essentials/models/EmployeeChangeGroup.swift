//
//  EmployeeChangegroup.swift
//  Essentials
//
//  Created by Jonathan Vanden Eynden on 21/12/2020.
//

import Foundation

struct EmployeeChangeGroup: Codable {
    public let employeeId : Int
    public let employee : Employee?
    public let changeGroupId : Int
    public let changeGroup: ChangeGroup?
    
    public enum CodingKeys: String, CodingKey {
        case employeeId = "employeeId"
        case employee = "employee"
        case changeGroupId = "changeGroupId"
        case changeGroup = "changeGroup"
    }
}
