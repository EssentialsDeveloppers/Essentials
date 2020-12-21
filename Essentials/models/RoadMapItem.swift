//
//  RoadMapItem.swift
//  Essentials
//
//  Created by Sébastien De Pauw on 21/12/2020.
//

import Foundation

class RoadMapItem: Codable {
    var id: Int
    var title: String
    var assessment: Assessment?
    var done: Bool
    var startDate: String
    var endDate: String
    
    public init?(id: Int, title: String, assessment: Assessment?, done: Bool, startDate: String, endDate: String) {
        if id < 0 || title.isEmpty || assessment == nil || startDate.isEmpty || endDate.isEmpty {
            return nil
        }
            self.id = id
            self.title = title
            self.assessment = assessment
            self.done = done
            self.startDate = startDate
            self.endDate = endDate
        }
        
        public enum CodingKeys: String, CodingKey {
            case id
            case title
            case assessment
            case done
            case startDate
            case endDate
        }
}
