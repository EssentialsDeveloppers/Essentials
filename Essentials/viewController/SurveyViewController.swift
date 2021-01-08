//
//  SurveyDetailsViewController.swift
//  Essentials
//
//  Created by Sébastien De Pauw on 27/12/2020.
//

import UIKit
import ReplayKit
import Alamofire

class SurveyViewController: UIViewController {
    //MARK: - Controller
    /// Local selected item
    var roadMapItem: RoadMapItem?
    var empId: Int = 0;
    var currentQuestion: Int = 0;

    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var yesNoView: UIView!
    @IBOutlet weak var ratingBarView: UIView!
    @IBOutlet weak var openView: UIView!
    @IBOutlet weak var MPView: UIView!
    @IBOutlet weak var MPStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Survey"
        initView()
        // Do any additional setup after loading the view.
    }
    
    private func initView(){
        guard let data = roadMapItem else { return }
        setEmployee()
        setLastFilledInQuestion(data:data)
        setUpScreen(data:data)
    }
    
    func setEmployee(){
        if(Globals.isChangeManager){
            empId = Globals.changeManager?.id ?? 0
        } else {
            empId = Globals.employee?.id ?? 0
        }
    }
    
    func setLastFilledInQuestion(data: RoadMapItem?){
        for i in 0 ..< (data?.assessment?.questions ?? []).count {
            if(data?.assessment?.questions[i].questionRegistered?.keys.contains(String(empId)) ?? false){
                currentQuestion = i
            }
        }
    }
    
    func setUpScreen(data: RoadMapItem?){
        let q = data?.assessment?.questions[currentQuestion] ?? nil
        
        if(q != nil){
            //set the question
            question.text = q?.questionString
            switch q?.type {
            case 0:
                yesNoQuestion(question:q)
            case 1:
                rangedQuestion(question:q)
            case 2:
                multipleChoiceQuestion(question:q)
            case 3:
                openQuestion(question:q)
            default: break;
            }
        }
        
        if(data?.assessment?.questions.count ?? 0 - currentQuestion + 1 < 0 ){
            nextBtn.setTitle("Finish", for: .normal)
        }else{
            nextBtn.setTitle("Next", for: .normal)
        }
    }
    
    func yesNoQuestion(question: Question?){
    
        for item in question?.possibleAnswers ?? [String: Int]() {

        }
    }
    
    func rangedQuestion(question: Question?){
        
        for item in question?.possibleAnswers ?? [String: Int]() {
        }
    }
    
    func multipleChoiceQuestion(question: Question?){
        
        MPView.isHidden = false
        var y = 0
        for item in question?.possibleAnswers ?? [String: Int]() {
            let button = UIButton()
            button.setTitle(item.key, for: .normal)
            button.frame = CGRect(x:0, y:y, width: 300, height: 60)
            y = y + 60
            button.addTarget(self,
                             action: #selector(SurveyViewController.buttonAction(sender:)),
                             for: .touchUpInside)
            MPStackView.addSubview(button)
        }
        
        
    }
    
    func openQuestion(question: Question?){
        
        for item in question?.possibleAnswers ?? [String: Int]() {
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let questions = segue.destination as? QuestionViewController else {
            return
        }
        questions.roadMapItem = roadMapItem
    }
    
    @objc
    func buttonAction(sender: UIButton!) {
        print(sender.currentTitle)
        //TODO add post method
        //TODO navigate
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

// MARK: - ALAMOFIRE API
extension SurveyViewController {
    func postQuestion(){
        AF.request(
            "https://essentialsapi-forios.azurewebsites.net/api/ChangeGroups/GetChangeGroupForUser/\(Globals.isChangeManager ? Globals.changeManager!.id : Globals.employee!.id)",
            method: .post,
            parameters: [:]
        ).validate().responseDecodable(of: [ChangeGroup].self) { (response) in
        }
    }
}
