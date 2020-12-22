//
//  EmployeeChangegroup.swift
//  Essentials
//
//  Created by Jonathan Vanden Eynden on 21/12/2020.
//

import Foundation

struct EmployeeChangeGroup: Codable {
    let employeeId : Int
    //var employee : Employee
    var changeGroupId : Int
    var changeGroup: ChangeGroup
    
    public enum CodingKeys: String, CodingKey {
        case employeeId = "id"
        //case employee = "employee"
        case changeGroupId = "changeGroupId"
        case changeGroup = "changeGroup"
    }
}
