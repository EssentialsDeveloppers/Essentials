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
    
    @IBOutlet weak var titleChangeInitiative: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var startDateTime: UILabel!
    @IBOutlet weak var endDateTime: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var addAlarmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    private func initView() {
        guard let data = changeInitiative else { return }
        titleChangeInitiative.text = data.title
        descriptionText.text = data.description
        startDateTime.text = formatDateTime(date: data.startDate)
        endDateTime.text = formatDateTime(date: data.endDate)
        progress.progress = Float(data.progress)
    }
    
    
    private func formatDateTime(date: String) -> String {
        let initialDateFormatter = DateFormatter()
        initialDateFormatter.dateFormat = "yyyy-mm-dd'T'HH:mm:ss.SSSSSSS"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm"
        
        let date: Date? = initialDateFormatter.date(from: date)
        return dateFormatter.string(from: date!)
    }
}
