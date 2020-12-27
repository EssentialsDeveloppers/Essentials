//
//  LoginViewController.swift
//  Essentials
//
//  Created by Ziggy Moens on 22/12/2020.
//

import UIKit
import Alamofire

/**
 - Author: Ziggy Moens
 */
class LoginViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    /// Local list of employees
    var employees: [Employee] = []
    /// Local list of change managers
    var changeManagers: [ChangeManager] = []
    /// Local selected empoyee
    var selectedEmployee: Employee?
    /// Local selected change manager
    var selectedChangeManager: ChangeManager?
    
    //MARK: - View
    /// Outlet to Picker View with name "Employee Picker" on the StoryBoard
    @IBOutlet weak var employeePicker: UIPickerView!
    /// Outlet to Picker View with name "ChangeManager Picker" on the StoryBoar
    @IBOutlet weak var changeManagerPicker: UIPickerView!
    /// Outlet to Switch with name "Change Manager Switch" on the StoryBoar
    @IBOutlet weak var changeManagerSwitch: UISwitch!
    /// Outlet to Activity Indicator View with name spinner on the StoryBoar
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //MARK: - Controller
    /**
     Overrides the function viewDidLoad, this one starts after the view has been loaded, here we will trigger the api calls and set the pickerViews & switch
     
     - Author: Ziggy Moens
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        employeePicker.delegate = self
        employeePicker.dataSource = self
        changeManagerPicker.delegate = self
        changeManagerPicker.dataSource = self
        
        changeManagerSwitch.setOn(false, animated: false)
        employeePicker.isHidden = true
        changeManagerPicker.isHidden = true
        
        fetchChangeManagers()
        fetchEmployees()
    }
    
    /**
     This method wil handle the triggered when the UISwitch is triggered
     
     When the trigger is on (isOn) then the pickerView of the change managers wil be shown
     When the trigger is not on then the pickerView of the employees wil be shown
     ### Remark:
     this functions also automaticly sets the first item in the pickerView as selected
     
     - Parameter sender: the UISwitch that has triggered the action
     - Returns: Void
     - Author: Ziggy Moens
     */
    @IBAction func ChangeManagerSwitch(_ sender: UISwitch) {
        if(sender.isOn){
            employeePicker.isHidden = true
            changeManagerPicker.isHidden = false
            self.changeManagerPicker.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(self.changeManagerPicker, didSelectRow: 0, inComponent: 0)
        } else {
            employeePicker.isHidden = false
            changeManagerPicker.isHidden = true
            self.employeePicker.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(self.employeePicker, didSelectRow: 0, inComponent: 0)
        }
    }
    
    /**
     Overrides the function pickerView, this one is to set the amount of items in the pickerview
     
     - Author: Ziggy Moens
     */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.tag == 1){
            return employees.count
        }else{
            return changeManagers.count
        }
    }
    
    /**
     Overrides the function pickerView, this one is to set each item in the pickerview
     
     - Author: Ziggy Moens
     */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView.tag == 1){
            return "\(employees[row].firstName) \(employees[row].lastName)"
        }else {
            return "\(changeManagers[row].firstName) \(changeManagers[row].lastName)"
        }
    }
    
    /**
     Overrides the function pickerView, this one is to get the selected item in the pickerview
     
     - Author: Ziggy Moens
     */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView.tag == 1){
            let user = self.employees[row]
            self.selectedEmployee = user
            self.selectedChangeManager = nil
            
        } else {
            let user = self.changeManagers[row]
            self.selectedEmployee = nil
            self.selectedChangeManager = user
        }
    }
    
    /**
     Overrides the function numberOfComponents
     
     - Author: Ziggy Moens
     */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    /**
     Overrides the function prepare, so data can be passed between the viewControllers
     
     - Author: Ziggy Moens
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let homescreen = segue.destination as? HomeViewController else {
            return
        }
        homescreen.isChangeManager = self.changeManagerSwitch.isOn
        homescreen.employee = self.selectedEmployee
        homescreen.changeManager = self.selectedChangeManager
    }
}


// MARK: - ALAMOFIRE API
extension LoginViewController {
    
    /**
     This method will get all the Empolyee objects out of the api
     
     ### Remark:
     For this app we are only gonna use employees/changemanagers from organization with id 1.
     ### Functionalities:
     This method will set the local employees list ot the employees from the api and then reload the right picker.
     Also will the spinner start and stop on the right moment.
     
     - Returns: Void
     - Requires: AlamoFire 5.2
     - Warning: A network connection is needed for this method
     - Author: Ziggy Moens
     */
    func fetchEmployees() {
        spinner.isHidden = false
        spinner.startAnimating()
        AF.request("https://essentialsapi-forios.azurewebsites.net/api/Employees/GetAllEmployeesFromOrganization/1").validate().responseDecodable(of: [Employee].self) { (response) in
            guard let employees = response.value else { return }
            self.employees = employees
            self.employeePicker.reloadAllComponents()
            self.employeePicker.isHidden = false
            self.spinner.isHidden = true
            self.spinner.stopAnimating()
            self.employeePicker.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(self.employeePicker, didSelectRow: 0, inComponent: 0)
        }
    }
    
    /**
     This method will get all the change managers **from the api**
     
     ### Remark:
     For this app we are only gonna use employees/changemanagers from organization with id 1.
     ### Functionalities:
     This method will set the local employees list ot the employees from the api and then reload the right picker.
     Also will the spinner start and stop on the right moment.
     
     - Returns: Void
     - Requires: AlamoFire 5.2
     - Warning: A network connection is needed for this method
     - Author: Ziggy Moens
     */
    func fetchChangeManagers(){
        spinner.isHidden = false
        spinner.startAnimating()
        AF.request("https://essentialsapi-forios.azurewebsites.net/api/ChangeManagers/GetChangeManagersFromOrganization/1").validate().responseDecodable(of: [ChangeManager].self) { (response) in
            guard let changeManagers = response.value else { return }
            self.changeManagers = changeManagers
            self.changeManagerPicker.reloadAllComponents()
            self.spinner.isHidden = true
            self.spinner.stopAnimating()
        }
    }
}
