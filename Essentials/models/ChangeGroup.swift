//
//  ChangeGroup.swift
//  Essentials
//
//  Created by Jonathan on 21/12/2020.
//

import Foundation

struct ChangeGroup {
    let id : Int
    var name : String
    var employeeChangeGroups : [EmployeeChangeGroup]
    
    init?(id : Int, name: String, employeeChangeGroups : [EmployeeChangeGroup]){
        if id < 0 || name.isEmpty || employeeChangeGroups.isEmpty {
            return nil
        }
        self.id = id
        self.name = name
        self.employeeChangeGroups = employeeChangeGroups
    }
}


