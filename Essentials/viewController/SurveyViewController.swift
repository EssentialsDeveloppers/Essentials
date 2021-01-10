//
//  SurveyDetailsViewController.swift
//  Essentials
//
//  Created by Sébastien De Pauw on 27/12/2020.
//

import UIKit
import ReplayKit
import Alamofire

/**
 - Author: Sébastien De Pauw
 */
class SurveyViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    //MARK: - Controller
    ///Local list of questions that are not yet filled in
    var questions: [Question] = []
    ///Current question we are on
    var currentQuestion: Question?
    ///A list of answers for the current question
    var listOfAnswers: [String] = []
    ///The selected item in the multiple choice picker
    var selectedMP: String?
    ///The selected item in the yes/no picker
    var selectedYN: String?
    ///Current questions index in questions array
    var currentQuestionIndex = 0
    ///Param passed with segue
    var rmi: RoadMapItem?
    ///A param for the star selected
    var starCount = 0;
    ///Param passed with segue to culculate the time
    var beginDate = Date()
    
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var yesNoView: UIView!
    @IBOutlet weak var ratingBarView: UIView!
    @IBOutlet weak var openView: UIView!
    @IBOutlet weak var MPView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var mpPicker: UIPickerView!
    @IBOutlet weak var ynPicker: UIPickerView!
    @IBOutlet weak var openTextField: UITextView!
    @IBOutlet weak var ratingBarStackView: UIStackView!
    @IBOutlet var ratingBarButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Survey"
        nextBtn.layer.cornerRadius = 10
        nextBtn.layer.masksToBounds = true
        initView()
    }
    
    /**
     Method to set up all important views on screen en redirect to based on current question
     - Author: Sébastien De Pauw
     */
    private func initView(){
        currentQuestion = questions[0]
        listOfAnswers.removeAll()
        for item in currentQuestion!.possibleAnswers {
            listOfAnswers.append(item.key)
        }
        listOfAnswers.sort()
        mpPicker.delegate = self
        mpPicker.dataSource = self
        ynPicker.delegate = self
        ynPicker.dataSource = self
        setUpScreen()
    }
    
    /**
     Method to set up all important views on screen en redirect to based on current question
     - Author: Sébastien De Pauw
     */
    func setUpScreen(){
        MPView.isHidden = true
        openView.isHidden = true
        ratingBarView.isHidden = true
        yesNoView.isHidden = true
        ynPicker.isHidden = true
        mpPicker.isHidden = true
        
        if(currentQuestion != nil){
            //set the question
            question.text = currentQuestion?.questionString
            //set the question view
            switch currentQuestion?.type {
            case 0:
                yesNoQuestion(question:currentQuestion)
            case 1:
                rangedQuestion(question:currentQuestion)
            case 2:
                multipleChoiceQuestion(question:currentQuestion)
            case 3:
                openQuestion(question:currentQuestion)
            default: break;
            }
        }
        
        nextBtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    /**
     Method to set up all important views on screen en redirect to based on current question
     - Author: Sébastien De Pauw
     */
    func yesNoQuestion(question: Question?){
        yesNoView.isHidden = false
        ynPicker.isHidden = false
        ynPicker.reloadAllComponents()
        self.mpPicker.selectRow(0, inComponent: 0, animated: true)
        self.pickerView(self.mpPicker, didSelectRow: 0, inComponent: 0)
    }
    
    func rangedQuestion(question: Question?){
        ratingBarView.isHidden = false
    }
    
    /**
     Method to set up all important views on screen en redirect to based on current question
     - Author: Sébastien De Pauw
     */
    @IBAction func buttonTapped(_ sender: UIButton) {
        starCount = sender.tag
        for button in ratingBarButtons {
            if button.tag <= sender.tag{
                button.setImage(UIImage(systemName: "star.fill"), for: .normal)
            } else {
                button.setImage(UIImage(systemName: "star"), for: .normal)
            }
        }
    }
    
    /**
     Method to set up all important views on screen en redirect to based on current question
     - Author: Sébastien De Pauw
     */
    func multipleChoiceQuestion(question: Question?){
        MPView.isHidden = false
        mpPicker.isHidden = false
        mpPicker.reloadAllComponents()
        self.mpPicker.selectRow(0, inComponent: 0, animated: true)
        self.pickerView(self.mpPicker, didSelectRow: 0, inComponent: 0)
    }
    
    /**
     Method to set up all important views on screen en redirect to based on current question
     - Author: Sébastien De Pauw
     */
    func openQuestion(question: Question?){
        openView.isHidden = false
    }
    
    /**
     Method to set up all important views on screen en redirect to based on current question
     - Author: Sébastien De Pauw
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let questions = segue.destination as! SurveyCompleteViewController
        questions.roadMapItem = self.rmi
        questions.beginDate = beginDate
        questions.navigationItem.hidesBackButton = true
    }
    
    /**
     Method to set up all important views on screen en redirect to based on current question
     - Author: Sébastien De Pauw
     */
    enum Segues{
        static let toSurveyCompleted = "toSurveyCompleted"
    }
    
    /**
     Method to set up all important views on screen en redirect to based on current question
     - Author: Sébastien De Pauw
     */
    @objc
    func buttonAction() {
        questions.remove(at: 0)
        var arr: [String] = []
        if(!yesNoView.isHidden){
            arr.append(selectedYN!)
        } else if(!MPView.isHidden) {
            arr.append(selectedMP!)
        } else if(!openView.isHidden){
            arr.append(openTextField.text)
        } else if(!ratingBarView.isHidden){
            arr.append(String(starCount))
        }
        postQuestion(params: arr)
        
        if(questions.isEmpty){
            performSegue(withIdentifier: SurveyViewController.Segues.toSurveyCompleted, sender: nil)
        } else {
            initView()
        }
    }

    /**
     Method to set up all important views on screen en redirect to based on current question
     - Author: Sébastien De Pauw
     */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.tag == 1){
            return listOfAnswers.count
        } else if (pickerView.tag == 2){
            return listOfAnswers.count
        }
        return 0
    }
    
    /**
     Method to set up all important views on screen en redirect to based on current question
     - Author: Sébastien De Pauw
     */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView.tag == 1){
            return listOfAnswers[row]
        } else if (pickerView.tag == 2){
            return listOfAnswers[row]
        }
        return ""
    }
    
    /**
     Method to set up all important views on screen en redirect to based on current question
     - Author: Sébastien De Pauw
     */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView.tag == 1){
            let answer = self.listOfAnswers[row]
            self.selectedMP = answer
            self.selectedYN = nil
            
        } else if (pickerView.tag == 2){
            let answer = self.listOfAnswers[row]
            self.selectedMP = nil
            self.selectedYN = answer
        }
    }
    
    /**
     Method to set up all important views on screen en redirect to based on current question
     - Author: Sébastien De Pauw
     */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

// MARK: - ALAMOFIRE API
/**
 extension to SurveyViewController containing the api calls
 
 - Author: Sébastien De Pauw
 */
extension SurveyViewController {
    /**
     This method will post a filled in question **to the api**
     
     - Returns: Void
     - Requires: AlamoFire 5.2
     - Warning: A network connection is needed for this method
     - Author: Sébastien De Pauw
     */
    func postQuestion(params: [String]){
        var request = URLRequest(url: URL(string: Globals.urlString + "/Questions/PostAnswerToQuestion/\(currentQuestion!.id)/\(Globals.employee!.id)")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: params)
        AF.request(request).responseJSON { (response) in
            //debugPrint(response)
        }
        
//        AF.request(
//            Globals.urlString + "/Questions/PostAnswerToQuestion/\(currentQuestion!.id)/\(empId)",
//            method: .post,
//            parameters: ["test"],
//            encoding: JSONEncoding.default
//        ).responseJSON { (response) in
//            debugPrint(response)
//                switch response.result {
//                case .success(_):
//                    print("succes")
//                    break
//                case .failure(let error):
//                    print(error)
//                    break
//                }
//            }

        }
    }
    
    

