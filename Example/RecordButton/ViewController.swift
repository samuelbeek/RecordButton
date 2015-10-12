//
//  ViewController.swift
//  RecordButton
//
//  Created by samuelbeek on 10/12/2015.
//  Copyright (c) 2015 samuelbeek. All rights reserved.
//

import UIKit
import RecordButton

class ViewController: UIViewController {
    
    var recordButton : RecordButton!
    var progressTimer : NSTimer!
    var progress : CGFloat! = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // set up recorder button 
        recordButton = RecordButton(frame: CGRectMake(0,0,70,70))
        recordButton.center = self.view.center
        recordButton.progressColor = .redColor()
        recordButton.closeWhenFinished = false
        recordButton.addTarget(self, action: "record", forControlEvents: .TouchDown)
        recordButton.addTarget(self, action: "stop", forControlEvents: UIControlEvents.TouchUpInside)
        recordButton.center.x = self.view.center.x
        view.addSubview(recordButton)

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func record() {
        self.progressTimer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: "updateProgress", userInfo: nil, repeats: true)
    }
    
    func updateProgress() {
        
        progress = progress + (CGFloat(0.05) / CGFloat(5))
        recordButton.setProgress(progress)
        
        if progress >= 1 {
            progressTimer.invalidate()
        }
        
    }
    
    func stop() {
        
        self.progressTimer.invalidate()
        
    }
    


}

