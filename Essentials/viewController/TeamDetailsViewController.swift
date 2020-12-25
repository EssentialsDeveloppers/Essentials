//
//  TeamDetailsViewController.swift
//  Essentials
//
//  Created by Jonathan Vanden Eynden Van Lysebeth on 23/12/2020.
//

import UIKit
/**
 - Author: Jonathan Vanden Eynden Van Lysebeth
 */
class TeamDetailsViewController : UITableViewController {
    //MARK: - CONTROLLER
    /// Local selected Employee
    var selectedEmployee: Employee?
    /// Local list of Employees
    var employees: [Employee] = [Employee]()
     /**
     - Author: Jonathan Vanden Eynden Van Lysebeth
     */
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    /**
     - Author: Jonathan Vanden Eynden Van Lysebeth
     - returns: The amount of cells in the Table View
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    /**
     Set the cell of the View Table equal to the name of the Employee
     - returns: The cell of the View Table
     - Author: Jonathan Vanden Eynden Van Lysebeth
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamDetailsCell", for: indexPath)
        let employee = employees[indexPath.row]
        cell.textLabel?.text = "\(employee.firstName) \(employee.lastName)"
        return cell
    }
    
    /**
     Sets the selected Employee equal to the selected cell
     - returns: The indexPath of the selected cell
     - Author: Jonathan Vanden Eynden Van Lysebeth
     */
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedEmployee = employees[indexPath.row]
        return indexPath
    }
    
    /**
     Passes the selected Employee to the next View Controller
     - Author: Jonathan Vanden Eynden Van Lysebeth
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let employeeInformation = segue.destination as? EmployeeInfoViewController else {
            return
        }
        employeeInformation.employee = selectedEmployee
    }
}
