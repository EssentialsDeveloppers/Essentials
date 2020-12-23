//
//  OrganizationPart.swift
//  Essentials
//
//  Created by Jonathan Vanden Eynden on 21/12/2020.
//

import Foundation

struct OrganizationPart : Codable{
    public let id : Int
    public let name : String
    public let employeeOrganizationPart : [EmployeeOrganizationPart]
    public let type : Int
    
    public enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case employeeOrganizationPart = "employeeOrganizationParts"
        case type = "type"
    }
    
}
