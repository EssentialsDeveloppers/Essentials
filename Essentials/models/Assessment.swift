//
//  Assessment.swift
//  Essentials
//
//  Created by Sébastien De Pauw on 21/12/2020.
//

import Foundation

class Assessment: Codable{
    var id: Int;
    var questions: [Question];
    var feedback: Question;
    var roadMapItemId: Int;
    
    public init?(id: Int, questions: [Question], feedback: Question, roadMapItemId: Int) {
        if id < 0 || roadMapItemId < 0 {
            return nil
        }
        self.id = id
        self.questions = questions
        self.feedback = feedback
        self.roadMapItemId = roadMapItemId
    }
        
    public enum CodingKeys: String, CodingKey {
        case id
        case questions
        case feedback
        case roadMapItemId
    }
}
