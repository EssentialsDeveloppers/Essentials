//
//  RoadMapItem.swift
//  Essentials
//
//  Created by Sébastien De Pauw on 21/12/2020.
//

import Foundation

struct RoadMapItem: Codable {
    public let id: Int
    public let title: String
    public let assessment: Assessment?
    public let done: Bool
    public let startDate: String
    public let endDate: String
    
//    public init?(id: Int, title: String, assessment: Assessment?, done: Bool, startDate: String, endDate: String) {
//        if id < 0 || title.isEmpty || assessment == nil || startDate.isEmpty || endDate.isEmpty {
//            return nil
//        }
//            self.id = id
//            self.title = title
//            self.assessment = assessment
//            self.done = done
//            self.startDate = startDate
//            self.endDate = endDate
//        }
        
        public enum CodingKeys: String, CodingKey {
            case id
            case title
            case assessment
            case done
            case startDate
            case endDate
        }
}
