//
//  Assessment.swift
//  Essentials
//
//  Created by Sébastien De Pauw on 21/12/2020.
//

import Foundation

struct Assessment: Codable{
    public let id: Int
    public let questions: [Question]
    public let feedback: Question
    public let roadMapItemId: Int

    //    public init?(id: Int, questions: [Question], feedback: Question, roadMapItemId: Int) {
    //        if id < 0 || roadMapItemId < 0 {
    //            return nil
    //        }
    //        self.id = id
    //        self.questions = questions
    //        self.feedback = feedback
    //        self.roadMapItemId = roadMapItemId
    //    }
    
    public enum CodingKeys: String, CodingKey {
        case id = "id"
        case questions = "questions"
        case feedback = "feedback"
        case roadMapItemId = "roadMapItemId"
    }
}
