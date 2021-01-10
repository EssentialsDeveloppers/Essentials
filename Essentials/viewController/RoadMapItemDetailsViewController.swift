//
//  EmployeeDetailsViewController.swift
//  Essentials
//
//  Created by Ziggy Moens on 22/12/2020.
//

import UIKit
import EventKit
import Alamofire
/**
 - Author: Ziggy Moens
 */
class RoadMapItemDetailsViewController: UIViewController {
    //MARK: - View
    ///Outlet to the title of the roadmap
    @IBOutlet weak var titleRoadMap: UILabel!
    ///Outlet to the startdate label
    @IBOutlet weak var startDateRoadMap: UILabel!
    ///Outlet to the enddate label
    @IBOutlet weak var endDateRoadMap: UILabel!
    ///Outlet to the amount of questions label
    @IBOutlet weak var AmountOfQuestionsRoadMap: UILabel!
    
    @IBOutlet weak var SurveyBtn: UIButton!
    
    //Outlet to the survey button
    @IBOutlet weak var surveyButton: UIButton!
    //MARK: - Controller
    ///
    var roadMapItem: RoadMapItem?
    /**
     Overrides the function viewDidLoad, this one starts after the view has been loaded, here we will trigger initView function
     
     - Author: Ziggy Moens
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    /**
     this function will initialize the text from the labels on the StoryBoard
     
     - Author: Ziggy Moens
     */
    private func initView(){
        fetchRoadMapItem()
        guard let data = roadMapItem else { return }
        titleRoadMap.text = data.title
        startDateRoadMap.text = getDateString(date: data.startDate)
        endDateRoadMap.text = getDateString(date: data.endDate)
        AmountOfQuestionsRoadMap.text = String(data.assessment!.questions.count)
        surveyButton.layer.cornerRadius = 10
        surveyButton.layer.masksToBounds = true
    }
    
    /**
     this function will make it possible to save the roadmapitem to the calendar, also check permissions and ask them if there not given
    
     - Author: Ziggy Moens
     - Remark: EXTRA FUNCTIONALITEIT
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
                                                DispatchQueue.main.async {
                                                    self!.insertEvent(store: eventStore)
                                                }
                                            } else {
                                                print("No access")
                                            }
                                        })
        default:
            let ac = UIAlertController.init(title: "Essentials",
                                            message: "Something went wrong while saving to calender.", preferredStyle: .alert)
            ac.addAction(UIAlertAction.init(title: "Close",
                                            style: .default, handler: nil))
            self.present(ac, animated: true, completion: nil)
        }
    }
    
    /**
     this function will make a calender event and save this in the calender of the iPhone
        
     - Author: Ziggy Moens
     - Remark: EXTRA FUNCTIONALITEIT
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
        } catch _ as NSError {
            let ac = UIAlertController.init(title: "Essentials",
                                            message: "Something went wrong while saving the event, please try again later.", preferredStyle: .alert)
            ac.addAction(UIAlertAction.init(title: "Close",
                                            style: .default, handler: nil))
            self.present(ac, animated: true, completion: nil)
        }
        print("Saved Event")
        Loading.stopLoading(view: self)
    }
    
    /**
        this function will take a string and parse this to a real Date
     
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
     this function will take a Date and parse this to a string with medium dateStyle and short timeStyle
     
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
