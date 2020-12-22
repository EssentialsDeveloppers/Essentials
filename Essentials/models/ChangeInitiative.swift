//
//  ChangeInitiative.swift
//  Essentials
//
//  Created by Ziggy Moens on 21/12/2020.
//

import Foundation

struct ChangeInitiative : Codable {
    
    public let id: Int
    public let title: String
    public let description: String
    public let startDate: String
    public let endDate: String
    public let changeType: ChangeType?
    public let changeGroup: [ChangeGroup]?
    public let changeSponsor: Employee
    public let roadMaps: [RoadMapItem]
    public let progress: Int
    
    public enum CodingKeys: String, CodingKey{
        case id = "id"
        case title = "name"
        case description = "description"
        case startDate = "startDate"
        case endDate = "endDate"
        case changeType = "changeType"
        case changeGroup = "changeGroup"
        case changeSponsor = "changeSponsor"
        case roadMaps = "roadMap"
        case progress = "progress"
    }
    
}
