//
//  ViewController.swift
//  Essentials
//
//  Created by Ziggy Moens on 21/12/2020.
//

import UIKit
import Alamofire

class EmployeeViewController: UITableViewController {
    var employees: [Employee] = [Employee]()
    var selectedItem: Employee?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchEmployees()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
        let item = employees[indexPath.row]
        cell.textLabel?.text = item.firstName + " " + item.lastName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedItem = employees[indexPath.row]
        return indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? EmployeeDetailsViewController else {
            return
        }
        destinationVC.data = selectedItem
    }
}


// MARK: - ALAMOFIRE API
extension EmployeeViewController {
    func fetchEmployees() {
        AF.request("https://essentialsapi-forios.azurewebsites.net/api/Employees/GetAllEmployeesFromOrganization/1").validate().responseDecodable(of: [Employee].self) { (response) in
            guard let employees = response.value else { return }
            self.employees = employees
            self.tableView.reloadData()
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
 
 
 override func viewDidLoad() {
 super.viewDidLoad()
 fetchEmployees()
 self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "dataCell")
 }
 
 override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 return employees.count
 }
 
 override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
 let item = employees[indexPath.row]
 cell.textLabel?.text = item.firstName + " " + item.lastName
 return cell
 }
 
 override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
 selectedEmployee = employees[indexPath.row]
 return indexPath
 }
 
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 guard let destinationEmployee = segue.destination as? EmployeeDetailsViewController else {
 return
 }
 destinationEmployee.data = selectedEmployee
 }
 }
 
 */
