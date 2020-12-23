//
//  OrganizationPart.swift
//  Essentials
//
//  Created by Jonathan Vanden Eynden on 21/12/2020.
//

import Foundation

struct OrganizationPart : Codable{
    public let id : String
    public let name : String
    public let employeeOrganizationPart : [EmployeeOrganizationPart]
    public let type : String
    
    public enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case employeeOrganizationPart = "employeeOrganizationPart"
        case type = "type"
    }
    
}
