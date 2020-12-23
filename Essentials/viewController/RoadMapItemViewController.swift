//
//  ViewController.swift
//  Essentials
//
//  Created by Ziggy Moens on 21/12/2020.
//

import UIKit
import Alamofire

class RoadMapItemViewController: UITableViewController {
    var roadMapItems: [RoadMapItem] = [RoadMapItem]()
    var selectedRoadMapItem: RoadMapItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchEmployees()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roadMapItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
        let item = roadMapItems[indexPath.row]
        cell.textLabel?.text = item.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedRoadMapItem = roadMapItems[indexPath.row]
        return indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsRoadMapItem = segue.destination as? RoadMapItemDetailsViewController else {
            return
        }
        detailsRoadMapItem.roadMapItem = selectedRoadMapItem
    }
}


// MARK: - ALAMOFIRE API
extension RoadMapItemViewController {
    func fetchEmployees() {
        AF.request("https://essentialsapi-forios.azurewebsites.net/api/ChangeInitiatives/GetChangeInitiativesForEmployee/\(Globals.isChangeManager ? Globals.changeManager!.id : Globals.employee!.id)").validate().responseDecodable(of: [ChangeInitiative].self) { (response) in
            print(response.debugDescription)
            guard let changeInitiatives = response.value else { return }
            var rmis = [RoadMapItem]()
            for changeInitiative in changeInitiatives{
                rmis += changeInitiative.roadMaps
            }
            self.roadMapItems = rmis
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
