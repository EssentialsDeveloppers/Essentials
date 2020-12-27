//
//  TeamViewController.swift
//  Essentials
//
//  Created by Jonathan Vanden Eynden Van Lysebeth on 23/12/2020.
//

import UIKit
import Alamofire

/**
 - Author: Jonathan Vanden Eynden Van Lysebeth
 */
class TeamViewController : UITableViewController {
    // MARK: - Controller
    /// Local list of Changegroups
    var changeGroups: [ChangeGroup] = [ChangeGroup]()
    /// Local selected change group
    var selectedChangeGroup: ChangeGroup?
    
    /**
     Overrides the function viewDidLoad, this one starts after the view has been loaded, here we will trigger the api call(s) and set the table view
     
     - Author: Jonathan Vanden Eynden Van Lysebeth
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTeams()
    }
    /**
     - Author: Jonathan Vanden Eynden Van Lysebeth
     - returns: The amount of cells in the Table View
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return changeGroups.count
    }
    
    /**
     Sets the cell of the View Table equal to the name of the Change Group
     - returns: The cell of the View Table
     - Author: Jonathan Vanden Eynden Van Lysebeth
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell", for: indexPath)
        let changeGroup = changeGroups[indexPath.row]
        cell.textLabel?.text = changeGroup.name
        return cell
    }
    
    /**
     Sets the selected Change Group equal to the selected cell
     - returns: The indexPath of the selected cell
     - Author: Jonathan Vanden Eynden Van Lysebeth
     */
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedChangeGroup = changeGroups[indexPath.row]
        return indexPath
    }
    
    /**
     Passes the employees of the selected Change Group to the next View Controller
     - Author: Jonathan Vanden Eynden Van Lysebeth
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsTeam = segue.destination as? TeamDetailsViewController else {
            return
        }
        var employees = [Employee]()
        selectedChangeGroup?.employeeChangeGroups?.forEach {
            eg in employees.append(eg.employee!)
        }               
        detailsTeam.employees = employees
    }
}


// MARK: - ALAMOFIRE API
/**
 Extension of TeamVeiwController that handles the API calls
 - Author: Jonathan Vanden Eynden Van Lysebeth
 */
extension TeamViewController {
    /**
     Get all the Change Groups of the person that is logged in
     ### Functionalities:
     Set the local Change Groups list to the Change Groups from the API and then reload the table
     - Requires: Alamofire 5.2
     - Warning: A network connection is needed for this method
     - Author: Jonathan Vanden Eynden Van Lysebeth
     */
    func fetchTeams(){
        AF.request("https://essentialsapi-forios.azurewebsites.net/api/ChangeGroups/GetChangeGroupForUser/\(Globals.isChangeManager ? Globals.changeManager!.id : Globals.employee!.id)").validate().responseDecodable(of: [ChangeGroup].self) { (response) in
            guard let changeGroups = response.value else { return }
            self.changeGroups = changeGroups
            self.tableView.reloadData()
        }
    }
}
