//
//  ChangeInitiativeController.swift
//  Essentials
//
//  Created by Kilian Hoefman on 28/12/2020.
//

import UIKit
import Alamofire

class ChangeInitiativeViewController: UITableViewController {

    var changeInitiatives: [ChangeInitiative] = []
    
    var selectedChangeInit: ChangeInitiative?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchChangeInitiatives()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return changeInitiatives.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChangeInitCell", for: indexPath)
        let changeInitiative = changeInitiatives[indexPath.row]
        cell.textLabel?.text = changeInitiative.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedChangeInit = changeInitiatives[indexPath.row]
        return indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsOfChangeInit = segue.destination as? ChangeInitiativeDetailsViewController else {
                return
        }
        let changeInitToPass = selectedChangeInit
        detailsOfChangeInit.changeInitiative = changeInitToPass
    }

}

extension ChangeInitiativeViewController {
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
