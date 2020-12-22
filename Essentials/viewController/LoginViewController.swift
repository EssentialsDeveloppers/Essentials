//
//  LoginViewController.swift
//  Essentials
//
//  Created by Ziggy Moens on 22/12/2020.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var employees: [Employee] = []
    var changeManagers: [ChangeManager] = []
    var selectedEmployee: Employee?
    var selectedChangeManager: ChangeManager?
    @IBOutlet weak var employeePicker: UIPickerView!
    @IBOutlet weak var changeManagerPicker: UIPickerView!
    @IBOutlet weak var changeManagerSwitch: UISwitch!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    @IBAction func ChangeManagerSwitch(_ sender: UISwitch) {
        if(sender.isOn){
            employeePicker.isHidden = true
            changeManagerPicker.isHidden = false
        } else {
            employeePicker.isHidden = false
            changeManagerPicker.isHidden = true
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.tag == 1){
            return employees.count
        }else{
            return changeManagers.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView.tag == 1){
            return "\(employees[row].firstName) \(employees[row].lastName)"
        }else {
            return "\(changeManagers[row].firstName) \(changeManagers[row].lastName)"
        }
    }
    
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
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
        }
    }
    
    func fetchChangeManagers() {
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
