//
//  SecondsLabel.swift
//  Screen Break 2
//
//  Created by Mayfield on 6/28/18.
//  Copyright © 2018 holophysics. All rights reserved.
//

import UIKit

class SecondsLabel: UILabel {

    // Keep track of the timer variables
    var initialSeconds = 0.0
    var remainingSeconds = 0.0

    // A method for hiding and showing this label
    // Why not let the label hide or show itself?
    func toggle() {
        
        self.isHidden = !self.isHidden
        
    }
    
}
