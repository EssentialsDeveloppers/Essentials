//
//  EmployeeInfoViewController.swift
//  Essentials
//
//  Created by Jonathan Vanden Eynden Van Lysebeth on 23/12/2020.
//

import UIKit
import Alamofire

class EmployeeInfoViewController: UIViewController {
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var listTableView: UITableView!
    
    var employee: Employee?
    var changeGroups: [ChangeGroup] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        listTableView.dataSource = self
        fetchTeamsUser()
    }
    
    private func initView(){
        guard let data = employee else { return }
        firstNameLabel.text = data.firstName
        lastNameLabel.text = data.lastName
        emailLabel.text = data.email
    }
    
}

// MARK: - UITableViewDataSource
extension EmployeeInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return changeGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "TeamsDataCell", for: indexPath)
      cell.textLabel?.text = changeGroups[indexPath.row].name
      return cell
    }
}



// MARK: - ALAMOFIRE API
extension EmployeeInfoViewController {
    func fetchTeamsUser(){
        AF.request("https://essentialsapi-forios.azurewebsites.net/api/ChangeGroups/GetChangeGroupForUser/\(Globals.isChangeManager ? Globals.changeManager!.id : Globals.employee!.id)").validate().responseDecodable(of: [ChangeGroup].self) { (response) in
            guard let changeGroups = response.value else { return }
            self.changeGroups = changeGroups
            self.listTableView.reloadData()
        }
    }
}



