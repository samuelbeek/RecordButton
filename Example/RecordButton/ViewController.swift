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
    var progressTimer : Timer!
    var progress : CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // set up recorder button 
        recordButton = RecordButton(frame: CGRect(x: 0,y: 0,width: 70,height: 70))
        recordButton.center = self.view.center
        recordButton.progressColor = UIColor.red
        recordButton.closeWhenFinished = false
        recordButton.addTarget(self, action: #selector(ViewController.record), for: .touchDown)
        recordButton.addTarget(self, action: #selector(ViewController.stop), for: UIControlEvents.touchUpInside)
        recordButton.center.x = self.view.center.x
        view.addSubview(recordButton)

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func record() {
        self.progressTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(ViewController.updateProgress), userInfo: nil, repeats: true)
    }
    
    func updateProgress() {
        
        let maxDuration = CGFloat(5) // Max duration of the recordButton
        
        progress = progress + (CGFloat(0.05) / maxDuration)
        recordButton.setProgress(progress)
        
        if progress >= 1 {
            progressTimer.invalidate()
        }
        
    }
    
    func stop() {
        self.progressTimer.invalidate()
    }
    


}

