//
//  EmployeeData.swift
//  Essentials
//
//  Created by Ziggy Moens on 22/12/2020.
//

import Foundation

class EmployeeData {
    
    let employeeAPI = EmployeeAPI()
    
    var employeesFromOrganization = [Employee]()
    
    func getEmployeesFromOrganization(organizationId: Int){
        employeeAPI.fetchEmployeesFromOrganization(organizationId: organizationId)
    }
    
    func getEmployeesFromOrganizationFromApi() {
        employeesFromOrganization = employeeAPI.employees
    }
    
    func returnEmployeesFromOrganizationFromApi()->[Employee] {
        return employeesFromOrganization
    }
}
