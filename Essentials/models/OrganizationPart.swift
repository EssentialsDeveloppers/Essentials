//
//  OrganizationPart.swift
//  Essentials
//
//  Created by Jonathan Vanden Eynden on 21/12/2020.
//

import Foundation

struct OrganizationPart : Codable{
    let id : String
    var name : String
    //var employeeOrganizationPart : EmployeeOrganizationPart
    var type : String
    
    public enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        //case employeeOrganizationPart = "employeeOrganizationPart"
        case type = "type"
    }
    
}
