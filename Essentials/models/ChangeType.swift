//
//  ChangeType.swift
//  Essentials
//
//  Created by Ziggy Moens on 21/12/2020.
//

import Foundation

struct ChangeType : Codable {
    public let id: Int
    
    public enum CodingKeys: String, CodingKey{
        case id = "id"
    }
}
