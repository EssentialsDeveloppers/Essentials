//
//  Question.swift
//  Essentials
//
//  Created by Sébastien De Pauw on 21/12/2020.
//

import Foundation

class Question: Codable{
    let id: Int
    var possibleAnswers: [String: Int]
    var questionString: String
    var type: String
    var questionRegistered: [String: String]?
    
    public init?(id: Int, possibleAnswers: [String: Int], questionString: String, type: String, questionRegistered: [String: String]?) {
        if id < 0 || questionString.isEmpty || type.isEmpty || questionRegistered == nil {
            return nil
        }
        self.id = id
        self.possibleAnswers = possibleAnswers
        self.questionString = questionString
        self.type = type
        self.questionRegistered = questionRegistered
    }   
        
    public enum CodingKeys: String, CodingKey {
        case id
        case possibleAnswers
        case questionString
        case type
        case questionRegistered
    }
}
