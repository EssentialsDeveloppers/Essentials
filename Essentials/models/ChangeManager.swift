//
//  ChangeManager.swift
//  Essentials
//
//  Created by Ziggy Moens on 21/12/2020.
//

import Foundation

struct ChangeManager : Codable{
    
   public let id: Int
   public let firstName: String
   public let lastName: String
   public let email: String
   public let createdChangeInitiatives: [ChangeInitiative]?
    
    public enum CodingKeys: String, CodingKey{
        case id = "id"
        case firstName = "firstName"
        case lastName = "lastName"
        case email = "email"
        case createdChangeInitiatives = "createdChangeInitiatives"
    }
}
