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
    
    func fetchEmployeesFromOrganization(organizationId: Int){
        self.group.enter()
        AF.request("https://essentialsapi-forios.azurewebsites.net/api/Employees/GetAllEmployeesFromOrganization/\(organizationId)").validate().responseDecodable(of: [Employee].self) { (response) in
            guard let employees = response.value else { return }
            self.employees = employees
            self.group.leave()
        }
        self.group.notify(queue: .main){
            
        }
    }
}
