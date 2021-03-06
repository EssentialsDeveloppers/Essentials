//
//  HomeViewController.swift
//  Essentials
//
//  Created by Ziggy Moens on 22/12/2020.
//

import UIKit

/**
 - Author: Ziggy Moens
 */
class HomeViewController: UIViewController {
    
    // MARK: - View
    /// Outlet to Label with name "Label Name" on the StoryBoard
    @IBOutlet weak var labelName: UILabel!
    /// Outlet to Label View with name "Label Type" on the StoryBoard
    @IBOutlet weak var labelType: UILabel!
    /// Outlet to Button View with name "Surveys Button" on the StoryBoard
    @IBOutlet weak var surveysButton: UIButton!
    /// Outlet to Button View with name "Change Initiatives Button" on the StoryBoard
    @IBOutlet weak var changeInitiativesButton: UIButton!
    /// Outlet to Button View with name "My Teams Button" on the StoryBoard
    @IBOutlet weak var myTeamsButton: UIButton!
    
    
    // MARK: - Controller
    /// local employee object, if isChangeManager is true, this object will be nil
    var employee: Employee?
    /// local change manager object, if isChangeManager is false, this object will be nil
    var changeManager: ChangeManager?
    /// local boolean to check if logged in user is a change manager
    var isChangeManager: Bool = false
    
    /**
     Overrides the function viewDidLoad, this one starts after the view has been loaded, here we will trigger the **initView()**
     
     - Author: Ziggy Moens
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        initView()
    }
    
    /**
     this function wil initialize the text from the labels on the StoryBoard, also setting the Globals in the project
     
     - Author: Ziggy Moens
     */
    func initView(){
        surveysButton.layer.cornerRadius = 10
        surveysButton.layer.masksToBounds = true
        
        changeInitiativesButton.layer.cornerRadius = 10
        changeInitiativesButton.layer.masksToBounds = true
        
        myTeamsButton.layer.cornerRadius = 10
        myTeamsButton.layer.masksToBounds = true
        
        if(isChangeManager){
            guard let data = changeManager else { return }
            labelName.text = "Welcome \(data.firstName)"
            Globals.changeManager = data
            Globals.isChangeManager = self.isChangeManager
        }else{
            guard let data = employee else { return }
            labelName.text = "Welcome \(data.firstName)"
            Globals.employee = data
        }
        labelType.text = isChangeManager ? "Your role is: Change Manager": "Your role is: Employee"
    }
    
}

//MARK: - Global Variables
/**
 Class containing the global variables for this project
 
 - Author: Ziggy Moens
 */
class Globals {
    /// Global boolean to check is user is a change manager
    static var isChangeManager: Bool = false
    /// Global Employee Object,  if isChangeManager is true, this object will be nil
    static var employee: Employee?
    /// Global Employee Object,  if isChangeManager is false, this object will be nil
    static var changeManager: ChangeManager?
    /// Global url for Post and Get methods
    static var urlString: String = "https://essentialsapi-forios.azurewebsites.net/api"
}
