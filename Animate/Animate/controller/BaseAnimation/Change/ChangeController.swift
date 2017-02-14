//
//  ChangeController.swift
//  Animate
//
//  Created by Mac on 17/2/7.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class ChangeController: UIViewController {

    @IBOutlet weak var bgColor: UIView!
    @IBOutlet weak var cornerRadius: UIView!
    @IBOutlet weak var borderColor: UIView!
    @IBOutlet weak var borderWidth: UIView!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var qqMsg: UIImageView!
    @IBOutlet weak var shadow: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimate()
    }
    
    func startAnimate(){
        
        //背景色
        let bgColorAnimate = Animate.baseAnimationWithKeyPath("backgroundColor", fromValue: nil, toValue: UIColor.green.cgColor, duration: 0.75, repeatCount: Float.infinity, timingFunction: nil)
        bgColorAnimate.autoreverses = true
        bgColor.layer.add(bgColorAnimate, forKey: "bgColorAnimate")
        
        //圆角
        let cornerAnimate = Animate.baseAnimationWithKeyPath("cornerRadius", fromValue: nil, toValue: 25, duration: 0.75, repeatCount: Float.infinity, timingFunction: nil)
        cornerAnimate.autoreverses = true
        cornerRadius.layer.add(cornerAnimate, forKey: "cornerRadius")
        
        //边框颜色
        let borderCAnimate = Animate.baseAnimationWithKeyPath("borderColor", fromValue: nil, toValue: UIColor.yellow.cgColor, duration: 0.75, repeatCount: Float.infinity, timingFunction: nil)
        borderCAnimate.autoreverses = true
        borderColor.layer.borderWidth = 5
        borderColor.layer.add(borderCAnimate, forKey: "borderColor")
        
        //边框
        let borderWAnimate = Animate.baseAnimationWithKeyPath("borderWidth", fromValue: 0, toValue: 5, duration: 0.75, repeatCount: Float.infinity, timingFunction: nil)
        borderWAnimate.autoreverses = true
        borderWidth.layer.borderColor = UIColor.red.cgColor
        borderWidth.layer.add(borderWAnimate, forKey: "borderWidth")
        
        //内容
        let img = UIImage(named:"icon2.jpg")
        let contentAnimate = Animate.baseAnimationWithKeyPath("contents", fromValue: nil, toValue: img?.cgImage, duration: 0.75, repeatCount: Float.infinity, timingFunction: nil)
        contentAnimate.autoreverses = true
        iconImgView.layer.add(contentAnimate, forKey: "contents")
        
        //不透明度
        let opacityAnimate = Animate.baseAnimationWithKeyPath("opacity", fromValue: nil, toValue: 0.2, duration: 0.1, repeatCount: Float.infinity, timingFunction: nil)
        opacityAnimate.autoreverses = true
        qqMsg.layer.add(opacityAnimate, forKey: "opacity")
        
        //阴影
        shadow.layer.shadowColor = UIColor(white: 0, alpha: 0.5).cgColor
        shadow.layer.shadowOffset = CGSize(width: 0, height: 3)
        shadow.layer.shadowRadius = 8
        let shadowAnimate = Animate.baseAnimationWithKeyPath("shadowOpacity", fromValue: 0, toValue: 0.8, duration: 0.5, repeatCount: Float.infinity, timingFunction: nil)
        shadowAnimate.autoreverses = true
        shadow.layer.add(shadowAnimate, forKey: "shadowOpacity")

    }

}
