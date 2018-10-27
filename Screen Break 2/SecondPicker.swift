//
//  SecondPicker.swift
//  Screen Break 2
//
//  Created by Mayfield on 6/28/18.
//  Copyright © 2018 holophysics. All rights reserved.
//

import UIKit

class SecondPicker: UIPickerView {

    // Keep track of the timer variables
    var initialSeconds = 0.0
    var remainingSeconds = 0.0
    
    // A method for hiding and showing this picker
    // Why not let the picker hide or show itself?
    func toggle() {
        
        self.isHidden = !self.isHidden
        
    }

}
