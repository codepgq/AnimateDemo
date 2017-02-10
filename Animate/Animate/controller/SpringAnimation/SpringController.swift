//
//  SpringController.swift
//  Animate
//
//  Created by Mac on 17/2/8.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class SpringController: UIViewController {

    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var redCircle: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        redCircle.layer.cornerRadius = 25
        redCircle.clipsToBounds = true
    }

    @IBAction func startAnimate(_ sender: UIButton) {
        
        redCircle.layer.removeAllAnimations()
        
        // y 方向
        let springAni = Animate.springAnimationWithPath("position.y", mass: textToCGFloat(text: lbl1.text!), stiffness: textToCGFloat(text: lbl2.text!), damping: textToCGFloat(text: lbl3.text!), fromValue: nil, toValue: UIScreen.main.bounds.height - 25)
        
        //颜色
//        let springAni = Animate.springAnimationWithPath("backgroundColor", mass: textToCGFloat(text: lbl1.text!), stiffness: textToCGFloat(text: lbl2.text!), damping: textToCGFloat(text: lbl3.text!), fromValue: nil, toValue: UIColor.green.cgColor)
        springAni.isRemovedOnCompletion = false
        springAni.fillMode = kCAFillModeForwards
        
        redCircle.layer.add(springAni, forKey: "positioin.y")
    }

    @IBAction func sliderValueChange(_ sender: UISlider) {
        let text = "\(sender.value)"
        if sender.tag == 1 {
            lbl1.text = text
        }else if sender.tag == 2{
            lbl2.text = text
        }else{
            lbl3.text = text
        }
    }
    
    func textToCGFloat(text : String) -> CGFloat {
        return CGFloat((text as NSString).floatValue)
    }
}
