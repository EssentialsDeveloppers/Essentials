//
//  ChangeType.swift
//  Essentials
//
//  Created by Ziggy Moens on 21/12/2020.
//

import Foundation

struct ChangeType {
    let id: Int
    
    init?(id: Int) {
        if id < 0 {
            return nil
        }
        self.id = id
    }
}
