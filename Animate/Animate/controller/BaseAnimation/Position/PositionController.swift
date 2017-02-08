//
//  PositionController.swift
//  Animate
//
//  Created by Mac on 17/2/7.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class PositionController: BaseViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var positionX: UITextField!
    @IBOutlet weak var positionY: UITextField!
    @IBOutlet weak var anchorPointX: UITextField!
    @IBOutlet weak var anchorPointY: UITextField!

    @IBAction func startAnimate(_ sender: Any) {
        
        hideKeyboard()
        
        imgView.layer.removeAllAnimations()
        
        let pX  = (positionX.text! as NSString).doubleValue
        let pY  = (positionY.text! as NSString).doubleValue
        let anchorX = (anchorPointX.text! as NSString).doubleValue
        let anchorY = (anchorPointY.text! as NSString).doubleValue
        
        
        let animate = Animate.baseAnimationWithKeyPath("position", fromValue: NSValue(cgPoint: CGPoint(x: 0, y: 64)), toValue: NSValue(cgPoint: CGPoint(x: pX, y: pY)), duration: 1.5, repeatCount: Float.infinity, timingFunction: kCAMediaTimingFunctionEaseOut)
        animate.autoreverses = true
        
        imgView.layer.anchorPoint = CGPoint(x: anchorX, y: anchorY)
        
        imgView.layer.add(animate, forKey: "position")
        
    }
}
