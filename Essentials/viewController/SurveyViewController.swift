//
//  SurveyDetailsViewController.swift
//  Essentials
//
//  Created by Sébastien De Pauw on 27/12/2020.
//

import UIKit
import ReplayKit
import Alamofire

class SurveyViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    //MARK: - Controller
    var questions: [Question] = []
    var currentQuestion: Question?
    var listOfAnswers: [String] = []
    var selectedMP: String?
    var selectedYN: String?
    var currentQuestionIndex = 0
    var rmi: RoadMapItem?
    
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var yesNoView: UIView!
    @IBOutlet weak var ratingBarView: UIView!
    @IBOutlet weak var openView: UIView!
    @IBOutlet weak var MPView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var mpPicker: UIPickerView!
    @IBOutlet weak var ynPicker: UIPickerView!
    @IBOutlet weak var openTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Survey"
        initView()
    }
    
    private func initView(){
        currentQuestion = questions[0]
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
    
    func multipleChoiceQuestion(question: Question?){
        MPView.isHidden = false
        mpPicker.isHidden = false
        mpPicker.reloadAllComponents()
        self.mpPicker.selectRow(0, inComponent: 0, animated: true)
        self.pickerView(self.mpPicker, didSelectRow: 0, inComponent: 0)
    }
    
    func openQuestion(question: Question?){
        openView.isHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let questions = segue.destination as! SurveyCompleteViewController
        questions.roadMapItem = self.rmi
        questions.navigationItem.hidesBackButton = true
    }
    
    enum Segues{
        static let toSurveyCompleted = "toSurveyCompleted"
    }
    
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
        } /*else if(!ratingBarView.isHidden){
            arr.append(<#T##newElement: String##String#>)
        }*/
        postQuestion(params: arr)
        
        if(questions.isEmpty){
            performSegue(withIdentifier: SurveyViewController.Segues.toSurveyCompleted, sender: nil)
        } else {
            initView()
        }
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listOfAnswers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return listOfAnswers[row]
    }
    
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

}

// MARK: - ALAMOFIRE API
extension SurveyViewController {
    func postQuestion(params: [String]){
        var request = URLRequest(url: URL(string: Globals.urlString + "/Questions/PostAnswerToQuestion/\(currentQuestion!.id)/\(Globals.employee!.id)")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: params)
        AF.request(request).responseJSON { (response) in
            debugPrint(response)
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
    
    

