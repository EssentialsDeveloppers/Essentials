//
//  ViewController.swift
//  Essentials
//
//  Created by Ziggy Moens on 21/12/2020.
//

import UIKit
import Alamofire

/**
 - Author: Ziggy Moens
 */
class RoadMapItemViewController: UITableViewController {
    //MARK: - Controller
    /// Local list of roadmapitems
    var roadMapItems: [RoadMapItem] = [RoadMapItem]()
    /// Local selected item
    var selectedRoadMapItem: RoadMapItem?
    
    /**
     Overrides the function viewDidLoad, this one starts after the view has been loaded, here we will trigger the api calls and set the tableview
     
     - Author: Ziggy Moens
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRoadMapItems()
    }
    
    /**
     Overrides the function pickerView, this one is to set the amount of items in the tableview
     
     - Author: Ziggy Moens
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roadMapItems.count
    }
    
    /**
     Overrides the function tableView, this one is to set each item in the tableview
     
     - Author: Ziggy Moens
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "roadMapItemCell", for: indexPath)
        let item = roadMapItems[indexPath.row]
        cell.textLabel?.text = item.title
        return cell
    }
    
    /**
     Overrides the function tableView, this one is to get the selected item in the tableview
     
     - Author: Ziggy Moens
     */
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedRoadMapItem = roadMapItems[indexPath.row]
        return indexPath
    }
    
    /**
    Overrides the function prepare, so data can be passed between the viewControllers
    
    - Author: Ziggy Moens
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsRoadMapItem = segue.destination as? RoadMapItemDetailsViewController else {
            return
        }
        detailsRoadMapItem.roadMapItem = selectedRoadMapItem
    }
}


// MARK: - ALAMOFIRE API
/**
 extension to RoadMapItemViewController containing the api calls
 
 - Author: Ziggy Moens
 */
extension RoadMapItemViewController {
    /**
     This method will get all the change initiatives **from the api**
     
     ### Functionalities:
     This method will set the local roadmapitems list to the roadmapitems from the api and then reload the table.
     
     - Returns: Void
     - Requires: AlamoFire 5.2
     - Warning: A network connection is needed for this method
     - Author: Ziggy Moens
     */
    func fetchRoadMapItems() {
        AF.request("https://essentialsapi-forios.azurewebsites.net/api/ChangeInitiatives/GetChangeInitiativesForEmployee/\(Globals.isChangeManager ? Globals.changeManager!.id : Globals.employee!.id)").validate().responseDecodable(of: [ChangeInitiative].self) { (response) in
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
