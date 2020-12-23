//
//  HomeViewController.swift
//  Essentials
//
//  Created by Ziggy Moens on 22/12/2020.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelType: UILabel!
    var employee: Employee?
    var changeManager: ChangeManager?
    var isChangeManager: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView(){
        if(isChangeManager){
            guard let data = changeManager else { return }
            labelName.text = data.firstName
            Globals.changeManager = data
            Globals.isChangeManager = self.isChangeManager
        }else{
            guard let data = employee else { return }
            labelName.text = data.firstName
            Globals.employee = data
        }
        labelType.text = isChangeManager ? "Change Manager": "Employee"
    }
    
}

class Globals {
     static var isChangeManager: Bool = false

     static var employee: Employee?
    
     static var changeManager: ChangeManager?
}
