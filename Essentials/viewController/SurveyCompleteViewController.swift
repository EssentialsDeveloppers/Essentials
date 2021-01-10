//
//  QuestionViewController.swift
//  Essentials
//
//  Created by Sébastien De Pauw on 27/12/2020.
//

import UIKit

class SurveyCompleteViewController: UIViewController {

    var roadMapItem: RoadMapItem?
    var beginDate: Date?
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var nrQuestionsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Survey was finished"
        headerLabel.text = "\(roadMapItem!.title) completed!"
        homeBtn.layer.cornerRadius = 10
        homeBtn.layer.masksToBounds = true
        setDetails()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(share(sender:)))
    }
    /**
    Override method to pass the Selected Change Initiative to the details View Controller via a segue
    - Author: Kilian Hoefman
    */
    func setDetails(){
        titleLabel.text?.append(roadMapItem!.title)
        nrQuestionsLabel.text?.append(String(roadMapItem!.assessment!.questions.count))
        let ti = Date().timeIntervalSinceReferenceDate - ((beginDate?.timeIntervalSinceReferenceDate) ?? Date().timeIntervalSinceReferenceDate)
        timeLabel.text?.append(stringFromTimeInterval(interval: ti) as String)
        
    }
    
    /**Override method to pass the Selected Change Initiative to the details View Controller via a segue
    - Author: Kilian Hoefman
    */
    func stringFromTimeInterval(interval: TimeInterval) -> NSString {
      let ti = NSInteger(interval)
      let ms = Int(((interval).truncatingRemainder(dividingBy: (1))) * 1000)
      let seconds = ti % 60
      let minutes = (ti / 60) % 60
      let hours = (ti / 3600)
      return NSString(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
    }
    
    @objc func share(sender:UIView){
            UIGraphicsBeginImageContext(view.frame.size)
            view.layer.render(in: UIGraphicsGetCurrentContext()!)
            UIGraphicsEndImageContext()

            let textToShare = "\(Globals.employee!.firstName) \(Globals.employee!.lastName) has finished \(roadMapItem!.title)"
            let myWebsite = URL(string: "https://essentialstoolkit.netlify.app")
        
            let objectsToShare = [textToShare, myWebsite!, #imageLiteral(resourceName: "essentials-logo")] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

            activityVC.popoverPresentationController?.sourceView = sender
            self.present(activityVC, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
