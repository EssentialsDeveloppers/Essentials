//
//  EmployeeDetailsViewController.swift
//  Essentials
//
//  Created by Ziggy Moens on 22/12/2020.
//

import UIKit
import EventKit

class RoadMapItemDetailsViewController: UIViewController {
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var roadMapItem: RoadMapItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        
        let eventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event){ granted, error in
            if (error != nil){
                print(error)
            }
        }
    }
    
    private func commonInit(){
        guard let data = roadMapItem else { return }
        
        firstNameLabel.text = data.title
        lastNameLabel.text = data.startDate
        emailLabel.text = data.endDate
    }
}
