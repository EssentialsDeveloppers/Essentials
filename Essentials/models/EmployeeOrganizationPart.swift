//
//  EmployeeOrganizationPart.swift
//  Essentials
//
//  Created by Kilian Hoefman on 22/12/2020.
//

import Foundation

class EmployeeOrganizationPart : Codable {
    var employeeId: Int
//    var employee: Employee
    var organizationPartId: Int
//    var organizationParts: OrganizationPart
    var type: String
    
    init?(employeeId: Int/*, employee: Employee*/, organizationPartId: Int/*, organizationParts: OrganizationPart*/, type: String){
        if employeeId < 0 || type.isEmpty {
            return nil
        }
        self.employeeId = employeeId
//        self.employee = employee
        self.organizationPartId = organizationPartId
//        self.organizationParts = organizationParts
        self.type = type
    }
    
    public enum CodingKeys: String, CodingKey{
        case employeeId = "employeeId"
//        case employee = "employee"
        case organizationPartId = "organizationPartId"
//        case organizationParts = "organizationParts"
        case type = "type"
    }
}
