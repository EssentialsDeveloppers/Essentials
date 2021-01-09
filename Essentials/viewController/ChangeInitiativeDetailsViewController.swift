//
//  ChangeInitiativeDetailsViewController.swift
//  Essentials
//
//  Created by Kilian Hoefman on 28/12/2020.
//

import Foundation
import UIKit
import MessageUI

class ChangeInitiativeDetailsViewController : UIViewController, MFMailComposeViewControllerDelegate {
    
    var changeInitiative : ChangeInitiative?
    
    @IBOutlet weak var titleChangeInitiative: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var startDateTime: UILabel!
    @IBOutlet weak var endDateTime: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var progressPercentage: UILabel!
    @IBOutlet weak var changeManagerName: UILabel!
    @IBOutlet weak var emailChangeManager: UILabel!
    @IBOutlet weak var mailToChangeManager: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    private func initView() {
        guard let data = changeInitiative else { return }
        
        //Change Initiative
        titleChangeInitiative.text = data.title
        descriptionText.text = data.description
        startDateTime.text = formatDateTime(date: data.startDate)
        endDateTime.text = formatDateTime(date: data.endDate)
        progress.progress = Float(data.progress)
        progressPercentage.text = String(format: "%d %%", data.progress)
                
        //Change Manager
        changeManagerName.text = data.changeSponsor!.firstName + " " + data.changeSponsor!.lastName
        emailChangeManager.text = data.changeSponsor!.email

    }
    
    @IBAction func sendMailToChangeManager(_ sender: UIButton!){
        let emailChangeManager = changeInitiative!.changeSponsor!.email
        let subject = "Questions about " + changeInitiative!.title + " initiative"
        let body = ""

        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([emailChangeManager])
            mail.setSubject(subject)
            mail.setMessageBody(body, isHTML: false)

            present(mail, animated: true)
        }else{
            let alert = UIAlertController(title: "Unavailable email", message: "The email service is currently unavailable on your device", preferredStyle: UIAlertController.Style.alert)
            let alertAction = UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default)
                    {
                        (UIAlertAction) -> Void in
                    }
                    alert.addAction(alertAction)
                    present(alert, animated: true)
                    {
                        () -> Void in
                    }
            
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
                controller.dismiss(animated: true)
            }
    
    
    /*
     Time formatter
     */
    private func formatDateTime(date: String) -> String {
        let initialDateFormatter = DateFormatter()
        initialDateFormatter.dateFormat = "yyyy-mm-dd'T'HH:mm:ss.SSSSSSS"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm"
        
        let date: Date? = initialDateFormatter.date(from: date)
        return dateFormatter.string(from: date!)
    }
}
