//
//  EmployeeDetailsViewController.swift
//  Essentials
//
//  Created by Ziggy Moens on 22/12/2020.
//

import UIKit
import EventKit
/**
 - Author: Ziggy Moens
 */
class RoadMapItemDetailsViewController: UIViewController {
    //MARK: - View
    ///
    @IBOutlet weak var titleRoadMap: UILabel!
    ///
    @IBOutlet weak var startDateRoadMap: UILabel!
    ///
    @IBOutlet weak var endDateRoadMap: UILabel!
    
    //MARK: - Controller
    ///
    var roadMapItem: RoadMapItem?
    
    /**
     - Author: Ziggy Moens
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    /**
     - Author: Ziggy Moens
     */
    private func initView(){
        guard let data = roadMapItem else { return }
        titleRoadMap.text = data.title
        startDateRoadMap.text = getDateString(date: data.startDate)
        endDateRoadMap.text = getDateString(date: data.endDate)
    }
    /**
     - Author: Ziggy Moens
     */
    @IBAction func addToCalender(_ sender: UIButton) {
        let eventStore = EKEventStore()
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            self.insertEvent(store: eventStore)
        case .denied:
            let ac = UIAlertController.init(title: "Essentials",
                                            message: "We don't have permission to your calendar", preferredStyle: .alert)
            ac.addAction(UIAlertAction.init(title: "Close",
                                            style: .default, handler: nil))
            self.present(ac, animated: true, completion: nil)
        case .notDetermined:
            eventStore.requestAccess(to: .event, completion:
                                        {[weak self] (granted: Bool, error: Error?) -> Void in
                                            if granted {
                                                self!.insertEvent(store: eventStore)
                                            } else {
                                                let ac = UIAlertController.init(title: "Essentials",
                                                                                message: "We don't have permission to your calendar", preferredStyle: .alert)
                                                ac.addAction(UIAlertAction.init(title: "Close",
                                                                                style: .default, handler: nil))
                                                self!.present(ac, animated: true, completion: nil)
                                            }
                                        })
        default:
            let ac = UIAlertController.init(title: "Essentials",
                                            message: "Something went wrong while saving to calender", preferredStyle: .alert)
            ac.addAction(UIAlertAction.init(title: "Close",
                                            style: .default, handler: nil))
            self.present(ac, animated: true, completion: nil)
        }
    }
    
    /**
     - Author: Ziggy Moens
     */
    func insertEvent(store: EKEventStore) {
        Loading.startLoading(view: self)
        let event:EKEvent = EKEvent(eventStore: store)
        event.title = roadMapItem?.title
        event.startDate = getDate(date: roadMapItem!.startDate)
        event.endDate = getDate(date: roadMapItem!.endDate)
        event.notes = "Please fill in the survey with \(roadMapItem!.title) before the road map item closes."
        event.calendar = store.defaultCalendarForNewEvents
        do {
            try store.save(event, span: .thisEvent)
        } catch let error as NSError {
            print("failed to save event with error : \(error)")
        }
        print("Saved Event")
        Loading.stopLoading(view: self)
    }
    
    /**
     - Author: Ziggy Moens
     */
    func getDate(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: String(date.prefix(21)))!
    }
    
    /**
     - Author: Ziggy Moens
     */
    func getDateString(date: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        let date = dateFormatter.date(from: String(date.prefix(21)))!
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
}
