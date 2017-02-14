//
//  ScaleController.swift
//  Animate
//
//  Created by Mac on 17/2/7.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class ScaleController: UIViewController {

    @IBOutlet weak var imgView1: UIImageView!
    @IBOutlet weak var imgView2: UIImageView!
    @IBOutlet weak var imgView3: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimation()
    }
    
    func startAnimation(){
        
        //Scale
        let scaleAnimate = Animate.baseAnimationWithKeyPath("transform.scale", fromValue: nil, toValue: 1.2, duration: 1.5, repeatCount: Float.infinity, timingFunction: nil)
        scaleAnimate.autoreverses = true
        imgView1.layer.add(scaleAnimate, forKey: "transform.scale")
        
        //Scale
        let scaleXAnimate = Animate.baseAnimationWithKeyPath("transform.scale.x", fromValue: nil, toValue: 2.0, duration: 1.5, repeatCount: Float.infinity, timingFunction: nil)
        scaleXAnimate.autoreverses = true
        imgView2.layer.add(scaleXAnimate, forKey: "transform.scale.x")
        
        //Scale
        let scaleYAnimate = Animate.baseAnimationWithKeyPath("transform.scale.y", fromValue: nil, toValue: 1.5, duration: 1.5, repeatCount: Float.infinity, timingFunction: nil)
        scaleYAnimate.autoreverses = true
        imgView3.layer.add(scaleYAnimate, forKey: "transform.scale.y")
    }

}
