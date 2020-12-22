//
//  HomeViewController.swift
//  Essentials
//
//  Created by Ziggy Moens on 22/12/2020.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var labelName: UILabel!
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
        }else{
            guard let data = employee else { return }
            labelName.text = data.firstName
        }
       
    }
    
}
