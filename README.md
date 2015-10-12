# RecordButton

[![CI Status](http://img.shields.io/travis/samuelbeek/RecordButton.svg?style=flat)](https://travis-ci.org/samuelbeek/RecordButton)
[![Version](https://img.shields.io/cocoapods/v/RecordButton.svg?style=flat)](http://cocoapods.org/pods/RecordButton)
[![License](https://img.shields.io/cocoapods/l/RecordButton.svg?style=flat)](http://cocoapods.org/pods/RecordButton)
[![Platform](https://img.shields.io/cocoapods/p/RecordButton.svg?style=flat)](http://cocoapods.org/pods/RecordButton)


A Record Button in Swift. Inspired by [SDRecordButton](https://github.com/sebyddd/SDRecordButton)
It shows you the recording process when recording. It's great for a video recorder app with a fixed/maximum length like snapchat, vine, instragram.

![Screenshot](http://imgur.com/S69GerW.gif)

## Requirements

iOS 8 and higher

## Example Project

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Installation

RecordButton is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby

pod "RecordButton", :git => "https://github.com/samuelbeek/RecordButton.git"

```

Add this line add the top of the file you want to use this module in `import RecordButton`


## Usage 

### Add a simple RecordButton

Add this to `viewDidLoad`

```swift 

let recordButton = RecordButton(frame: CGRectMake(0,0,70,70))
view.addSubview(recordButton) 

``` 

### Update progress 
*it's the easiest to just check out the example project for this.*

To update progress the RecordButton must be an instance of the class. You should also add a `progressTimer` and a `progress` variable, like this: 

```swift 

class ViewController: UIViewController {

	var recordButton : RecordButton!
	var progressTimer : NSTimer!
	var progress : CGFloat! = 0
	
	// rest of viewController 
	
```

The `recordButton` needs a target for start and stopping the progress timer. Add this code after initialization of the `recordButton` (usualy in `viewDidLoad()`)

```swift

recordButton.addTarget(self, action: "record", forControlEvents: .TouchDown)
recordButton.addTarget(self, action: "stop", forControlEvents: UIControlEvents.TouchUpInside)

```

Finally add these functions to your ViewController 

```swift

    func record() {
        self.progressTimer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: "updateProgress", userInfo: nil, repeats: true)
    }
    
    func updateProgress() {
        
        let maxDuration = CGFloat(5) // max duration of the recordButton
        
        progress = progress + (CGFloat(0.05) / maxDuration)
        recordButton.setProgress(progress)
        
        if progress >= 1 {
            progressTimer.invalidate()
        }
        
    }
    
    func stop() {
        self.progressTimer.invalidate()
    }
    
```


## To Do 
* Add Carthage Support
* Add a delegation pattern

## Author

[samuelbeek](http://twitter.com/samuelbeek) - iOS Developer, Consultant and Occasional Designer

## Acknowledgements
This button is heavely inspired by [SDRecordButton](https://github.com/sebyddd/SDRecordButton), which is made by [Sebyddd](https://github.com/sebyddd)

## License

RecordButton is available under the MIT license. See the LICENSE file for more info.
