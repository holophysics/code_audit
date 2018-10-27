//
//  MinutePicker.swift
//  Screen Break 2
//
//  Created by Mayfield on 6/28/18.
//  Copyright © 2018 holophysics. All rights reserved.
//

import UIKit

class MinutePicker: UIDatePicker {

    var initialMinutes = 0
    var initialSeconds = 0
    var remainingTime = 0

    // Why not let the picker hide or show itself?
    func toggle() {
        
        self.isHidden = !self.isHidden
        
    }
    
}
