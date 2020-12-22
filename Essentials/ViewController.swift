//
//  ViewController.swift
//  Essentials
//
//  Created by Ziggy Moens on 21/12/2020.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    var employees: [Employee] = [Employee]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        
        let url = "https://essentialsapi-forios.azurewebsites.net/api/Employees/GetAllEmployeesFromOrganization/1"
        func fetchEmployees() {
            AF.request(url).validate().responseDecodable(of: [Employee].self) { (response) in
                guard let employees = response.value else { return }
                DispatchQueue.main.async {
                    self.employees = employees
                }
            }
        }
    }
}


/*
 
 // Do any additional setup after loading the view.
 
 /*AF.request("https://httpbin.org/get").responseJSON{
 respons in debugPrint(respons)
 }*/
 /*
 var bearerToken = "Bearer "
 let params = ["email":"ziggy@hogent.com", "password":"P@ssword1"]
 AF.request("https://essentialsapi.azurewebsites.net/api/Account/Login", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON{
 (data) in print(data)
 
 }
 print(bearerToken)
 */
 
 /*AF.request("https://essentialsapi.azurewebsites.net/api/Admins").responseJSON{
 respons in debugPrint(respons)
 }*/
 
 /*AF.request("https://essentialsapi-forios.azurewebsites.net/api/Employees/3").responseJSON{
 respons in debugPrint(respons)
 }*/
 
 
 
 
 */
