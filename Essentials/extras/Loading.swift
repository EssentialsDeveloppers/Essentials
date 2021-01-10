//
//  Loading.swift
//  Essentials
//
//  Created by Ziggy Moens on 23/12/2020.
//

import UIKit

/**
 class to make a loading alert
 
 - Author: Ziggy Moens
 */
struct Loading{
    /**
     showing a loading alert with a animating spinner
     
     - Authors: Ziggy Moens
     */
    static func startLoading(view: UIViewController){
        let alert = UIAlertController(title: "Essentials", message: "Please wait...", preferredStyle: .alert)
        let spinner = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 75, height: 75))
        spinner.hidesWhenStopped = true
        spinner.color = UIColor.gray
        spinner.startAnimating();
        alert.view.addSubview(spinner)
        view.present(alert, animated: true, completion: nil)
    }
    
    /**
     hiding the active loading alert
     
     - Author: Ziggy Moens
     */
    static func stopLoading(view: UIViewController){
        view.dismiss(animated: false, completion: nil)
    }
}
