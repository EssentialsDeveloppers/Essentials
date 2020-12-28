//
//  ChangeInitiativeDetailsViewController.swift
//  Essentials
//
//  Created by Kilian Hoefman on 28/12/2020.
//

import Foundation
import UIKit

class ChangeInitiativeDetailsViewController : UIViewController {
    
    var changeInitiative : ChangeInitiative?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(changeInitiative?.changeType?.id ?? "oops")
        print(changeInitiative?.changeSponsor?.firstName ?? "oops")
        print(changeInitiative?.description ?? "oops")
        print(changeInitiative?.progress ?? "oops")
    }
}
