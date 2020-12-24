//
//  TeamDetailsViewController.swift
//  Essentials
//
//  Created by Jonathan Vanden Eynden Van Lysebeth on 23/12/2020.
//

import UIKit

class TeamDetailsViewController : UITableViewController {
    var selectedEmployee: Employee?
    var employees: [Employee] = [Employee]()
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamDetailsCell", for: indexPath)
        let employee = employees[indexPath.row]
        cell.textLabel?.text = "\(employee.firstName) \(employee.lastName)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedEmployee = employees[indexPath.row]
        return indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let employeeInformation = segue.destination as? EmployeeInfoViewController else {
            return
        }
        employeeInformation.employee = selectedEmployee
    }
}
