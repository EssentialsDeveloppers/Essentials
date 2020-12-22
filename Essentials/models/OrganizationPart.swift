//
//  OrganizationPart.swift
//  Essentials
//
//  Created by Jonathan on 21/12/2020.
//

import Foundation

struct OrganizationPart {
    let id : String
    var name : String
    // var employeeOrganizationParts : EmployeeOrganizationParts
    var type : String
    
    init?(id : String, name: String/* ,employeeOrganizationParts : EmployeeOrganizationParts */, type : String ){
        if id.isEmpty || name.isEmpty || type.isEmpty {
            return nil
        }
        self.id = id
        self.name = name
        // self.employeeOrganizationParts = employeeOrganizationParts
        self.type = type        
    }
}
