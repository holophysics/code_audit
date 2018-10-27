//
//  ViewController.swift
//  Screen Break 2
//
//  Created by Mayfield on 6/20/18.
//  Copyright © 2018 holophysics. All rights reserved.
//
//TODO: Work on pausing/resuming the seconds timer!!

import UIKit
import AVFoundation


class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // These variables will be needed for a global way to figure out what to pause or stop when buttons are pushed.
    var minutesRunning = Bool()
    var secondsRunning = Bool()
    
    // These timers are defined in the broadest scope possible so that we can invalidate them from any subprocess.
    var minuteTimer: Timer!
    var secondTimer: Timer!
    
    // How many seconds we have to choose from for the screen break
    var secondsInSecondPicker = 15
   
    // Below are outlets for all of the user interface elements. Many are subclassed with unique properties and methods.
    @IBOutlet weak var minutePicker: MinutePicker!
    @IBOutlet weak var secondPicker: SecondPicker!
    @IBOutlet weak var secondsLabel: SecondsLabel!
    
    @IBOutlet weak var minutesLabel: MinutesLabel!
    @IBOutlet weak var minuteDescription: UILabel!
   
    
    @IBOutlet weak var startCancelButton: UIButton!
    
    @IBOutlet weak var secondsDescription: UILabel!
    @IBOutlet weak var pauseResumeTimers: UIButton!
    
 // Codes that runs when the secondsTimer fires.
    @objc func runSecondsCode() {
        
        // As long as the counter is above 0, keep lowering the time and refiring
        if secondPicker.remainingSeconds >= 0.0 {
            
            secondsLabel.text = String(format: "%2.2f", secondPicker.remainingSeconds)
            secondPicker.remainingSeconds -= 0.01
            
        } else { // follow these procedures when the counter is 0. TODO: can we incorporate these procedures in the
            // counter itself?
            
            secondTimer.invalidate()
            
            // Play an alert sound
            
            
            secondsDescription.text = "Number of Seconds in Break"
            minuteDescription.text = "Number of Minutes between Breaks"
            startCancelButton.setTitle("Start Timers", for: UIControl.State.normal)
            secondsLabel.toggle()
            minutePicker.toggle()
            minutesLabel.toggle()
            secondPicker.toggle()
            pauseResumeTimers.isHidden = true
            
        }
        
    }
    
    // This code will run whenever minuteTimer fires.
    @objc func runMinutesCode() {
       
        minutesLabel.remainingSeconds -= 1
        
        // When the counter is down to 0, change some of the information labels. Then create the secondTimer and fire.
        // Temporarily count in 10 second increments so I don't have to wait while debugging! MUST CHANGE BACK TO 1.
        if minutesLabel.remainingSeconds <= 0 {
            minuteTimer.invalidate()
            minuteDescription.text = "Screen Break!"
            
            /*Play an alert sound
            var catSoundEffect: AVAudioPlayer?
            let mainBundle = Bundle.main
            let path = mainBundle.path(forResource: "cat", ofType: "wav")
            if path != nil {
                
                let url = URL(fileURLWithPath: path!)
                
            } else {
                
                let url = nil
            }
            
            do {
                catSoundEffect = try AVAudioPlayer(contentsOf: url)
                catSoundEffect?.play()
            } catch {
                //couldn't load file :(
            } */
            
            let secondsFrame = secondPicker.frame
            secondPicker.toggle()
            secondsLabel.toggle()
            secondsLabel.frame = secondsFrame
            let seconds = secondPicker.selectedRow(inComponent: 0) + 1
            secondsLabel.text = String(format: "0:%02d", seconds)
            secondsDescription.text = "Seconds Left in Break:"
            
            secondsRunning = true
            minutesRunning = !secondsRunning
            secondTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(runSecondsCode), userInfo: nil, repeats: true)
            
        }
        else { // Run the minutes countdown.
            
            secondPicker.initialSeconds = Double(secondPicker.selectedRow(inComponent: 0) + 1)
            secondPicker.remainingSeconds = Double(secondPicker.initialSeconds)
            minutesLabel.text = "\(String(format: "%02d",minutesLabel.remainingSeconds / 60)):\(String(format: "%02d",minutesLabel.remainingSeconds % 60))"
            
        }
        
    }
  
    
    @IBAction func startCancelPressed(_ sender: UIButton) {
        // If the button is labeled "Start Timers", then change its name to "Cancel Timers" and start running the minute timer.
        if sender.titleLabel!.text == "Start Timers"  {
            sender.setTitle("Cancel Timers", for: UIControl.State.normal)
            
            // Time to start running the minute timer
            // First to set up the CountdownLabel
            minutesLabel.initialMinutes = Int(minutePicker.countDownDuration)/60
            let newFrame = minutePicker.frame
            minutePicker.toggle()
            minutesLabel.text = "\(String(format: "%02d",minutesLabel.initialMinutes)):00"
            minutesLabel.toggle()
            minutesLabel.frame = newFrame
            
            minutesLabel.initialSeconds = minutesLabel.initialMinutes * 60
            minutesLabel.remainingSeconds = minutesLabel.initialSeconds/60 //TODO: Remove the /60 please!
            minuteDescription.text = "Time left until Break:"
            
            // Now show the pause/resume button
            pauseResumeTimers.isHidden = false
            
            // Create the minute timer! It will continue to fire until invalidated.
            
            minutesRunning = true
            minuteTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runMinutesCode), userInfo: nil, repeats: true)
            minutesRunning = true
            secondsRunning = !minutesRunning
            
            
        } else {  // This code happens when the button which now says "Cancel Timers" is pressed.
            
            minuteDescription.text = "Number of Minutes between Breaks"
            minutesLabel.toggle()
            minutePicker.toggle()
            secondsLabel.isHidden = true
            secondPicker.isHidden = false
            pauseResumeTimers.isHidden = true
            pauseResumeTimers.setTitle("Pause Timers", for: UIControl.State.normal)
            
            if minutesRunning == true {
                
                minuteTimer.invalidate()
                minutesRunning = false
                
            }
            
            sender.setTitle("Start Timers", for: UIControl.State.normal)
            
            if secondsRunning == true {
                
                secondTimer.invalidate()
                secondsRunning = false
                
            }
            
        }
        
    }
    
   
    @IBAction func pauseResumePressed(_ sender: UIButton) {
        
       
        // Check the label of the button to see which action we are performing.
        
        if sender.titleLabel!.text == "Pause Timers" {
            
            sender.setTitle("Resume Timers", for: UIControl.State.normal)
            // Check which timers are actually running and save their time data.
            if minutesRunning == true {
            
                minuteTimer.invalidate()
                
            
            }
        
            if secondsRunning == true {
            
                secondTimer.invalidate()
                
            
            }
        } else {
            
            sender.setTitle("Pause Timers", for: UIControl.State.normal)
            if minutesRunning == true {
                
                minuteTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runMinutesCode), userInfo: nil, repeats: true)
                
            } else if secondsRunning == true {
                
                secondTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(runSecondsCode), userInfo: nil, repeats: true)
                
            }
            
            
        }
    }
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return secondsInSecondPicker
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row + 1)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // MARK: set up interface elements
        secondPicker.dataSource = self
        secondPicker.delegate = self
        minutePicker.countDownDuration = 0
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

