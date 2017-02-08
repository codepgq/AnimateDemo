//
//  RotationController.swift
//  Animate
//
//  Created by Mac on 17/2/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class RotationController: BaseViewController {

    @IBOutlet weak var rotationImg: UIImageView!
    
    @IBOutlet weak var textY: UITextField!
    @IBOutlet weak var textX: UITextField!
    
//    自定义XY
    @IBAction func rotationXY(_ sender: Any) {
        let x : Double = (textX.text! as NSString).doubleValue
        let y : Double = (textY.text! as NSString).doubleValue
        rotationImg.layer.anchorPoint = CGPoint(x: x, y: y)
        rotationImg.layer.removeAllAnimations()
        let animate = Animate.baseAnimationWithKeyPath("transform.rotation.z", fromValue: nil , toValue: 2 * M_PI, duration: 1.0, repeatCount: Float.infinity, timingFunction: kCAMediaTimingFunctionLinear)
        rotationImg.layer.add(animate, forKey: "transform.rotation.z")
    }
    
    @IBAction func rotationX(_ sender: Any) {
        rotationImg.layer.removeAllAnimations()
        let animate = Animate.baseAnimationWithKeyPath("transform.rotation.x", fromValue: nil , toValue: 2 * M_PI, duration: 1.0, repeatCount: Float.infinity, timingFunction: kCAMediaTimingFunctionLinear)
        rotationImg.layer.add(animate, forKey: "transform.rotation.x")
    }
    
    @IBAction func rotationY(_ sender: Any) {
        rotationImg.layer.removeAllAnimations()
        let animate = Animate.baseAnimationWithKeyPath("transform.rotation.y", fromValue: nil , toValue: 2 * M_PI, duration: 1.0, repeatCount: Float.infinity, timingFunction: kCAMediaTimingFunctionEaseIn)
        rotationImg.layer.add(animate, forKey: "transform.rotation.y")
    }
    
    @IBAction func rotationZ(_ sender: Any) {
        rotationImg.layer.removeAllAnimations()
        let animate = Animate.baseAnimationWithKeyPath("transform.rotation.z", fromValue: nil , toValue: 2 * M_PI, duration: 1.0, repeatCount: Float.infinity, timingFunction: kCAMediaTimingFunctionEaseOut)
        rotationImg.layer.add(animate, forKey: "transform.rotation.z")
    }
    
}
