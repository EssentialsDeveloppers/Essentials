//
//  Employee.swift
//  Essentials
//
//  Created by Ziggy Moens on 21/12/2020.
//

import Foundation

class Employee {
    
    var id: Int
    var firstName: String
    var lastName: String
    var email: String
    //var employeeChangeGroup: [EmployeeChangeGroup]
    
    init?(id: Int, firstName: String, lastName: String, email: String/*, employeeChangeGroup: [EmployeeChangeGroup]*/) {
        if id < 0 || firstName.isEmpty || lastName.isEmpty || email.isEmpty {
            return nil
        }
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        //self.employeeChangeGroup = employeeChangeGroup ?? [EmployeeChangeGroup]()
    }
    
}
