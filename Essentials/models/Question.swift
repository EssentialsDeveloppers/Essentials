//
//  Question.swift
//  Essentials
//
//  Created by Sébastien De Pauw on 21/12/2020.
//

import Foundation

struct Question: Codable{
    public let id: Int
    public let possibleAnswers: [String: Int]
    public let questionString: String
    public let type: String
    public let questionRegistered: [String: String]?
    
//    public init?(id: Int, possibleAnswers: [String: Int], questionString: String, type: String, questionRegistered: [String: String]?) {
//        if id < 0 || questionString.isEmpty || type.isEmpty || questionRegistered == nil {
//            return nil
//        }
//        self.id = id
//        self.possibleAnswers = possibleAnswers
//        self.questionString = questionString
//        self.type = type
//        self.questionRegistered = questionRegistered
//    }   
        
    public enum CodingKeys: String, CodingKey {
        case id = "id"
        case possibleAnswers = "possibleAnswers"
        case questionString = "questionString"
        case type = "type"
        case questionRegistered = "questionRegistered"
    }
}
