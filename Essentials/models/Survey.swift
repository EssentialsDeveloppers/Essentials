//
//  Survey.swift
//  Essentials
//
//  Created by Sébastien De Pauw on 21/12/2020.
//

import Foundation

class Survey: Codable{
    let id: Int
    var questions: [Question]
    var feedback: Question
    var roadMapItemId: Int
    var roadMapItem: RoadMapItem?
    
    public init?(id: Int, questions: [Question], feedback: Question, roadMapItemId: Int, roadMapItem: RoadMapItem?) {
        if id < 0 || roadMapItemId < 0 || roadMapItem == nil {
            return nil
        }
        self.id = id
        self.questions = questions
        self.feedback = feedback
        self.roadMapItemId = roadMapItemId
        self.roadMapItem = roadMapItem
    }
    
    public enum CodingKeys: String, CodingKey {
        case id
        case questions
        case feedback
        case roadMapItemId
        case roadMapItem
    }
}
