//
//  ViewController.swift
//  Essentials
//
//  Created by Ziggy Moens on 21/12/2020.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        AF.request("https://httpbin.org/get").responseJSON{
            respons in debugPrint(respons)
        }
    }


}

