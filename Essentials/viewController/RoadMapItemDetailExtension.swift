//
//  RoadMapItemDetailExtension.swift
//  Essentials
//
//  Created by Sébastien De Pauw on 10/01/2021.
//

import Foundation
import UIKit
import Alamofire

extension RoadMapItemDetailsViewController {
    enum Segues{
        static let toSurveyCompleted = "toSurveyCompleted"
        static let toSurvey = "toSurvey"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.toSurveyCompleted {
            let surveyComplete = segue.destination as! SurveyCompleteViewController
            surveyComplete.roadMapItem = roadMapItem
        } else if segue.identifier == Segues.toSurvey {
            let survey = segue.destination as! SurveyViewController
            survey.questions = notFilledInQuestionArrayInit()
            survey.rmi = roadMapItem
        }
    }
    
    @IBAction func surveyButtonTapped(_ sender: UIButton) {
        let arr = notFilledInQuestionArrayInit()
        if arr.isEmpty{
            performSegue(withIdentifier: RoadMapItemDetailsViewController.Segues.toSurveyCompleted, sender: nil)
        } else{
            performSegue(withIdentifier: RoadMapItemDetailsViewController.Segues.toSurvey, sender: nil)
        }
    }
    
    func notFilledInQuestionArrayInit() -> [Question]{
        var arr: [Question] = []
        if(!Globals.isChangeManager){
            for i in 0 ..< roadMapItem!.assessment!.questions.count {
                if(!roadMapItem!.assessment!.questions[i].questionRegistered!.keys.contains(String(Globals.employee!.id))){
                    arr.append(roadMapItem!.assessment!.questions[i])
                }
            }
        }
        return arr
    }
}

// MARK: - ALAMOFIRE API
extension RoadMapItemDetailsViewController {
func fetchRoadMapItem() {
    AF.request(Globals.urlString + "/RoadMapItems/\(self.roadMapItem!.id)").validate().responseDecodable(of: RoadMapItem.self) { (response) in
            guard let rmi = response.value else { return }
            self.roadMapItem = rmi
        }
    }
}
