//
//  TeamViewController.swift
//  Essentials
//
//  Created by Jonathan Vanden Eynden Van Lysebeth on 23/12/2020.
//

import UIKit
import Alamofire


class TeamViewController : UITableViewController {
    var changeGroups: [ChangeGroup] = [ChangeGroup]()
    var selectedChangeGroup: ChangeGroup?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTeams()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return changeGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell", for: indexPath)
        let changeGroup = changeGroups[indexPath.row]
        cell.textLabel?.text = changeGroup.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedChangeGroup = changeGroups[indexPath.row]
        return indexPath
    }
    
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
extension TeamViewController {
    func fetchTeams(){
        AF.request("https://essentialsapi-forios.azurewebsites.net/api/ChangeGroups/GetChangeGroupForUser/\(Globals.isChangeManager ? Globals.changeManager!.id : Globals.employee!.id)").validate().responseDecodable(of: [ChangeGroup].self) { (response) in
            guard let changeGroups = response.value else { return }
            self.changeGroups = changeGroups
            self.tableView.reloadData()
        }
    }
}
