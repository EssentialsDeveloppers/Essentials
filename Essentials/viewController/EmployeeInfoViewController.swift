//
//  EmployeeInfoViewController.swift
//  Essentials
//
//  Created by Jonathan Vanden Eynden Van Lysebeth on 23/12/2020.
//

import UIKit
import Alamofire
import Contacts

/**
 - Author: Jonathan Vanden Eynden Van Lysebeth
 
 */
class EmployeeInfoViewController: UIViewController {
    // MARK: - View
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var fullNameLabel: UILabel!
    
    var employee: Employee?
    var changeGroups: [ChangeGroup] = []
    
    /**
     Initialize view, set the listTableView dataSource to self and get all the Teams of the  user
     - Author: Jonathan Vanden Eynden Van Lysebeth
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        listTableView.dataSource = self
        fetchTeamsUser()
    }
    
    /**
     Set all view objects (outlets) to their correct data
     - Author: Jonathan Vanden Eynden Van Lysebeth
     */
    private func initView(){
        guard let data = employee else { return }
        firstNameLabel.text = data.firstName
        lastNameLabel.text = data.lastName
        emailLabel.text = data.email
        fullNameLabel.text = "\(data.firstName) \(data.lastName)"
    }
    
    /**
     Button to add contact to the device's Contacts
     ### Functionalities
     - Makes a new contact if the device has access to the contacts
     - Displays an alert if the device does not have access to the contacts
     - Author: Jonathan Vanden Eynden Van Lysebeth
     */
    @IBAction func addContacts(_ sender: Any) {
        let contactStore = CNContactStore()
        
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            self.insertContact(store: contactStore)
        case .denied:
            let ac = UIAlertController.init(title: "Essentials", message: "We don't have permission to your contacts", preferredStyle: .alert)
            ac.addAction(UIAlertAction.init(title: "Close", style: .default, handler: nil))
        case .notDetermined:
            contactStore.requestAccess(for: .contacts, completionHandler:
                                        {[weak self] (granted: Bool, error: Error?) -> Void in
                                            if granted {
                                                DispatchQueue.main.async {
                                                    self!.insertContact(store: contactStore)
                                                }
                                            } else {
                                                print("No access")
                                            }
                                        })
        default:
            let ac = UIAlertController.init(title: "Essentials", message: "Something went wrong while saving to contacts.", preferredStyle: .alert)
            ac.addAction(UIAlertAction.init(title: "Close", style: .default, handler: nil))
            self.present(ac, animated: true, completion: nil)
        }
    }
    
    /**
     Make contact object and set Labels of View to contact attributes
     - Author: Jonathan Vanden Eynden Van Lysebeth
     */
    func insertContact(store: CNContactStore) {
        let contact = CNMutableContact()
        contact.givenName = firstNameLabel.text!
        contact.familyName = lastNameLabel.text!
        contact.emailAddresses = [CNLabeledValue(label: CNLabelWork, value: emailLabel.text! as NSString)]
        let saveRequest = CNSaveRequest()
        saveRequest.add(contact, toContainerWithIdentifier: nil)
        do {
            try store.execute(saveRequest)
        } catch {
            print("Saving contact failed, error: \(error)")
        }
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



