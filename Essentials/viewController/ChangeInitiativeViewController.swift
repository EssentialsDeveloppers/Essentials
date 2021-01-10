//
//  ChangeInitiativeController.swift
//  Essentials
//
//  Created by Kilian Hoefman on 28/12/2020.
//

import UIKit
import Alamofire

class ChangeInitiativeViewController: UITableViewController {

    /// List of changeInitiatives that gets loaded by the API
    var changeInitiatives: [ChangeInitiative] = []
    
    /// Selected Change Initiative used in Segue
    var selectedChangeInit: ChangeInitiative?
    
    /**
     - Author: Kilian Hoefman
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchChangeInitiatives()
    }
    
    /**
     Override function for tableView & number of rows
     - Author: Kilian Hoefman
     - returns: The amount of table cells in the Table View
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return changeInitiatives.count
    }
    
    /**
     Override function for tableView & index
     - Author: Kilian Hoefman
     - returns: The specific cell at the given index
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChangeInitCell", for: indexPath)
        let changeInitiative = changeInitiatives[indexPath.row]
        cell.textLabel?.text = changeInitiative.title
        return cell
    }
    
    /**
     Override function for tableview & selected cell
     - Author: Kilian Hoefman
     - returns: The index of the selected cell
     */
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedChangeInit = changeInitiatives[indexPath.row]
        return indexPath
    }
    
    /**
     Override method to pass the Selected Change Initiative to the details View Controller via a segue
     - Author: Kilian Hoefman
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsOfChangeInit = segue.destination as? ChangeInitiativeDetailsViewController else {
                return
        }
        let changeInitToPass = selectedChangeInit
        detailsOfChangeInit.changeInitiative = changeInitToPass
    }

}

//MARK: - ALAMOFIRE API CALL

/**
Extension of ChangeInitiativeViewController for API call
 */
extension ChangeInitiativeViewController {
    /**
     Function for fetching the Change Initiatives coming from the API
     - Author: Kilian Hoefman
     Fills the ChangeInitiatives list with data from the API
     */
    func fetchChangeInitiatives(){
        AF.request("https://essentialsapi-forios.azurewebsites.net/api/ChangeInitiatives/GetChangeInitiativesForEmployee/\(Globals.isChangeManager ? Globals.changeManager!.id : Globals.employee!.id)")
            .validate().responseDecodable(of: [ChangeInitiative].self) {
                response in
                guard let changeInits = response.value else { return }
                self.changeInitiatives = changeInits
                self.tableView.reloadData()
            }
    }
}
