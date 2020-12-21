//
//  EmployeeChangegroup.swift
//  Essentials
//
//  Created by Jonathan on 21/12/2020.
//

import Foundation

class EmployeeChangeGroup {
    var employeeId : Int
    var employee : Employee
    var changeGroupId : Int
    var changeGroup: ChangeGroup
    
    init?(employeeId: Int, employee : Employee, changeGroupId : Int, changeGroup : ChangeGroup){
        if employeeId < 0 || changeGroupId < 0 {
            return nil
        }
        self.employeeId = employeeId
        self.employee = employee
        self.changeGroupId = changeGroupId
        self.changeGroup = changeGroup
    }
}
