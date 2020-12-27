//
//  EmployeeOrganizationPart.swift
//  Essentials
//
//  Created by Kilian Hoefman on 22/12/2020.
//

import Foundation

struct EmployeeOrganizationPart : Codable {
    public let employeeId: Int
    public let employee: Employee?
    public let organizationPartId: Int
    public let organizationParts: OrganizationPart
    public let type: Int?
    
    public enum CodingKeys: String, CodingKey{
        case employeeId = "employeeId"
        case employee = "employee"
        case organizationPartId = "organizationPartId"
        case organizationParts = "organizationPart"
        case type = "type"
    }
}
