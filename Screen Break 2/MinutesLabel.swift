//
//  MinutesLabel.swift
//  Screen Break 2
//
//  Created by Mayfield on 10/5/18.
//  Copyright © 2018 holophysics. All rights reserved.
//

import UIKit

class MinutesLabel: UILabel {
    
    // These properties help keep track of the timer.
    var initialMinutes: Int = 0
    var initialSeconds: Int = 0
    var remainingSeconds: Int = 0
    
    
    // Why not let the label hide or show itself?
    func toggle() {
        
        self.isHidden = !self.isHidden
        
    }
    
    
    
}
