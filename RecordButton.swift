//
//  RecordButton.swift
//  Instant
//
//  Created by Samuel Beek on 21/06/15.
//  Copyright (c) 2015 Samue Beek. All rights reserved.
//

class RecordButton : UIButton {
    
    var buttonColor: UIColor! = .blueColor(){
        didSet {
            circleLayer.backgroundColor = buttonColor.CGColor
            circleBorder.borderColor = buttonColor.CGColor
        }
    }
    var progressColor: UIColor!  = .redColor() {
        didSet {
            gradientMaskLayer.colors = [progressColor.CGColor, progressColor.CGColor]
        }
    }
    var circleLayer: CALayer!
    var circleBorder: CALayer!
    var progressLayer: CAShapeLayer!
    var gradientMaskLayer: CAGradientLayer!
    var currentProgress: CGFloat!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: "didTouchDown", forControlEvents: .TouchDown)
        self.addTarget(self, action: "didTouchUp", forControlEvents: .TouchUpInside)
        self.addTarget(self, action: "didTouchUp", forControlEvents: .TouchUpOutside)

        self.drawButton()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func drawButton() {
        currentProgress = 0
        self.backgroundColor = UIColor.clearColor()
        let layer = self.layer
        circleLayer = CALayer()
        circleLayer.backgroundColor = buttonColor.CGColor
        let size: CGFloat = self.frame.size.width / 1.5
        circleLayer.bounds = CGRectMake(0, 0, size, size)
        circleLayer.anchorPoint = CGPointMake(0.5, 0.5)
        circleLayer.position = CGPointMake(CGRectGetMidX(self.bounds),CGRectGetMidY(self.bounds))
        circleLayer.cornerRadius = size / 2
        layer.insertSublayer(circleLayer, atIndex: 0)
        
        if !(circleBorder != nil) {
            circleBorder = CALayer()
            circleBorder.backgroundColor = UIColor.clearColor().CGColor
            circleBorder.borderWidth = 1
            circleBorder.borderColor = buttonColor.CGColor
            circleBorder.bounds = CGRectMake(0, 0, self.bounds.size.width - 1.5, self.bounds.size.height - 1.5)
            circleBorder.anchorPoint = CGPointMake(0.5, 0.5)
            circleBorder.position = CGPointMake(CGRectGetMidX(self.bounds),CGRectGetMidY(self.bounds))
            circleBorder.cornerRadius = self.frame.size.width / 2
            layer.insertSublayer(circleBorder, atIndex: 0)
            
            if !(progressLayer != nil) {
                let startAngle: CGFloat = CGFloat(M_PI) + CGFloat(M_PI_2)
                let endAngle: CGFloat = CGFloat(M_PI) * 3 + CGFloat(M_PI_2)
                let centerPoint: CGPoint = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
                gradientMaskLayer = self.gradientMask()
                progressLayer = CAShapeLayer()
                progressLayer.path = UIBezierPath(arcCenter: centerPoint, radius: self.frame.size.width / 2 - 2, startAngle: startAngle, endAngle: endAngle, clockwise: true).CGPath
                progressLayer.backgroundColor = UIColor.clearColor().CGColor
                progressLayer.fillColor = nil
                progressLayer.strokeColor = UIColor.blackColor().CGColor
                progressLayer.lineWidth = 4.0
                progressLayer.strokeStart = 0.0
                progressLayer.strokeEnd = 0.0
                gradientMaskLayer.mask = progressLayer
                layer.insertSublayer(gradientMaskLayer, atIndex: 0)
            }
        }
    }
    
    
    
    
    func gradientMask() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.locations = [0.0, 1.0]
        let topColor = progressColor
        let bottomColor = progressColor
        gradientLayer.colors = [topColor.CGColor, bottomColor.CGColor]
        return gradientLayer
    }
    
    override func layoutSubviews() {
        circleLayer.anchorPoint = CGPointMake(0.5, 0.5)
        circleLayer.position = CGPointMake(CGRectGetMidX(self.bounds),CGRectGetMidY(self.bounds))
        circleBorder.anchorPoint = CGPointMake(0.5, 0.5)
        circleBorder.position = CGPointMake(CGRectGetMidX(self.bounds),CGRectGetMidY(self.bounds))
        super.layoutSubviews()
    }
    

    func didTouchDown(){
        var duration: NSTimeInterval = 0.15
        circleLayer.contentsGravity = "center"
        var scale = CABasicAnimation(keyPath: "transform.scale")
        scale.fromValue = 1.0
        scale.toValue = 0.88
        scale.duration = duration
        scale.fillMode = kCAFillModeForwards
        scale.removedOnCompletion = false
        let color = CABasicAnimation(keyPath: "backgroundColor")
        color.duration = duration
        color.fillMode = kCAFillModeForwards
        color.removedOnCompletion = false
        color.toValue = progressColor.CGColor
        let circleAnimations = CAAnimationGroup()
        circleAnimations.removedOnCompletion = false
        circleAnimations.fillMode = kCAFillModeForwards
        circleAnimations.duration = duration
        circleAnimations.animations = [scale, color]
        let borderColor: CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
        borderColor.duration = duration
        borderColor.fillMode = kCAFillModeForwards
        borderColor.removedOnCompletion = false
        borderColor.toValue = UIColor(red: 0.83, green: 0.86, blue: 0.89, alpha: 1).CGColor
        let borderScale = CABasicAnimation(keyPath: "transform.scale")
        // circleBorder.presentationLayer().valueForKeyPath("transform.scale").floatValue()
        
        if let layer = circleBorder.presentationLayer() {
            borderScale.fromValue = layer.valueForKeyPath("transform.scale")?.floatValue
        }
        
        borderScale.toValue = 0.88
        borderScale.duration = duration
        borderScale.fillMode = kCAFillModeForwards
        borderScale.removedOnCompletion = false
        let borderAnimations = CAAnimationGroup()
        borderAnimations.removedOnCompletion = false
        borderAnimations.fillMode = kCAFillModeForwards
        borderAnimations.duration = duration
        borderAnimations.animations = [borderColor, borderScale]
        let fadeIn = CABasicAnimation(keyPath: "opacity")
        fadeIn.fromValue = 0.0
        fadeIn.toValue = 1.0
        fadeIn.duration = duration
        fadeIn.fillMode = kCAFillModeForwards
        fadeIn.removedOnCompletion = false
        progressLayer.addAnimation(fadeIn, forKey: "fadeIn")
        circleBorder.addAnimation(borderAnimations, forKey: "borderAnimations")
        circleLayer.addAnimation(circleAnimations, forKey: "circleAnimations")

    
    }
    
    func didTouchUp() {
        let duration: NSTimeInterval = 0.15
        let scale: CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        scale.fromValue = 0.88
        scale.toValue = 1.0
        scale.duration = duration
        scale.fillMode = kCAFillModeForwards
        scale.removedOnCompletion = false
        let color: CABasicAnimation = CABasicAnimation(keyPath: "backgroundColor")
        color.fillMode = kCAFillModeForwards
        color.removedOnCompletion = false
        color.toValue = buttonColor.CGColor
        let animations: CAAnimationGroup = CAAnimationGroup()
        animations.removedOnCompletion = false
        animations.fillMode = kCAFillModeForwards
        animations.duration = duration
        animations.animations = [scale, color]
        let borderColor: CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
        borderColor.duration = duration
        borderColor.fillMode = kCAFillModeForwards
        borderColor.removedOnCompletion = false
        borderColor.toValue = buttonColor.CGColor
        let borderScale: CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        borderScale.fromValue = 0.88
        borderScale.toValue = 1.0
        borderScale.duration = duration
        borderScale.fillMode = kCAFillModeForwards
        borderScale.removedOnCompletion = false
        let borderAnimations: CAAnimationGroup = CAAnimationGroup()
        borderAnimations.removedOnCompletion = false
        borderAnimations.fillMode = kCAFillModeForwards
        borderAnimations.duration = duration
        borderAnimations.animations = [borderColor, borderScale]
        let fadeOut: CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        fadeOut.fromValue = 1.0
        fadeOut.toValue = 0.0
        fadeOut.duration = duration * 2
        fadeOut.fillMode = kCAFillModeForwards
        fadeOut.removedOnCompletion = false
        progressLayer.addAnimation(fadeOut, forKey: "fadeOut")
        circleBorder.addAnimation(borderAnimations, forKey: "borderAnimations")
        circleLayer.addAnimation(animations, forKey: "circleAnimations")
    }
    
    
    func setProgress(newProgress: CGFloat) {
        progressLayer.strokeEnd = newProgress
    }
    

}

