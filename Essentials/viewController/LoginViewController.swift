//
//  LoginViewController.swift
//  Essentials
//
//  Created by Ziggy Moens on 22/12/2020.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    var employees: [Employee]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchEmployees()
    }
    
    
    
}


// MARK: - ALAMOFIRE API
extension LoginViewController {
    func fetchEmployees() {
        AF.request("https://essentialsapi-forios.azurewebsites.net/api/Employees/GetAllEmployeesFromOrganization/1").validate().responseDecodable(of: [Employee].self) { (response) in
            guard let employees = response.value else { return }
            self.employees = employees
        }
    }
}
