//
//  EmployeeAPI.swift
//  Essentials
//
//  Created by Ziggy Moens on 22/12/2020.
//

import Foundation
import Alamofire

class EmployeeAPI{
    
    var employees: [Employee] = [Employee]()
    
    let group = DispatchGroup()
    
    func fetchEmployees() -> [Employee]{
        AF.request("https://essentialsapi-forios.azurewebsites.net/api/Employees/GetAllEmployeesFromOrganization/1").validate().responseDecodable(of: [Employee].self) { (response) in
            guard let employees = response.value else { return }
            self.employees = employees
        }
        return self.employees
    }
}
