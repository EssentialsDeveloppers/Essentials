//
//  SpecialSegues.swift
//  Essentials
//
//  Created by Ziggy Moens on 24/12/2020.
//

import UIKit

/**
 custom segue without animation
 
 - Author: Ziggy Moens
 */
class NoAnimationSegue: UIStoryboardSegue {
    override func perform() {
        self.source.navigationController?.pushViewController(self.destination, animated: false)
    }
}
