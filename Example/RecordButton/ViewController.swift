//
//  ViewController.swift
//  RecordButton
//
//  Created by samuelbeek on 10/12/2015.
//  Copyright (c) 2015 samuelbeek. All rights reserved.
//

import UIKit
import RecordButton
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}


class ViewController: UIViewController {
    
    var recordButton : RecordButton!
    var progressTimer : Timer!
    var progress : CGFloat! = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // set up recorder button 
        recordButton = RecordButton(frame: CGRect(x: 0,y: 0,width: 70,height: 70))
        recordButton.center = self.view.center
        recordButton.progressColor = .red
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

    @objc func record() {
        self.progressTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(ViewController.updateProgress), userInfo: nil, repeats: true)
    }
    
    @objc func updateProgress() {
        
        let maxDuration = CGFloat(5) // Max duration of the recordButton
        
        progress = progress + (CGFloat(0.05) / maxDuration)
        recordButton.setProgress(progress)
        
        if progress >= 1 {
            progressTimer.invalidate()
        }
        
    }
    
    @objc func stop() {
        self.progressTimer.invalidate()
    }
    


}

