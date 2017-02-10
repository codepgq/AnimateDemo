//
//  KeyFrameController.swift
//  Animate
//
//  Created by Mac on 17/2/7.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

let circlePath = UIBezierPath(roundedRect: CGRect.init(x: 100, y: 200, width: 200, height: 200), cornerRadius: 100).cgPath



class KeyFrameController: UIViewController {

    fileprivate lazy var circleLayer : CAShapeLayer = {
        //添加一个layer显示轨迹
        let circleLayer = CAShapeLayer()
        
        //描边颜色
        circleLayer.strokeColor = UIColor.orange.cgColor
        
        //填充颜色
        circleLayer.fillColor = nil
        
        circleLayer.lineCap = kCALineCapRound
        
        circleLayer.lineJoin = kCALineJoinRound
        
        //边框宽度
        circleLayer.lineWidth = 0.5
        
        //路径
        circleLayer.path = circlePath
        
        return circleLayer
    }()
    
    fileprivate lazy var rectLayer : CAShapeLayer = {
        //添加一个layer显示轨迹
        let circleLayer = CAShapeLayer()
        
        //描边颜色
        circleLayer.strokeColor = UIColor.orange.cgColor
        
        //填充颜色
        circleLayer.fillColor = nil
        
        circleLayer.lineCap = kCALineCapRound
        
        circleLayer.lineJoin = kCALineJoinRound
        
        //边框宽度
        circleLayer.lineWidth = 0.5
        
        let rectPath = CGPath(rect: CGRect.init(x: 150, y: 200, width: 100, height: 100), transform: nil)
        
        //路径
        circleLayer.path = rectPath
        
        return circleLayer
    }()
    
    @IBOutlet weak var ImgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func rectPath(_ sender: Any) {
        
        circleLayer.removeFromSuperlayer()
        
        ImgView.layer.removeAllAnimations()
        
        let values = [NSValue(cgPoint: CGPoint(x: 150, y: 200)),
                      NSValue(cgPoint: CGPoint(x: 250, y: 200)),
                      NSValue(cgPoint: CGPoint(x: 250, y: 300)),
                      NSValue(cgPoint: CGPoint(x: 150, y: 300)),
                      NSValue(cgPoint: CGPoint(x: 150, y: 200))]
        
        let keyTimes = [NSNumber(value: 0.0),
                        NSNumber(value: 0.1),
                        NSNumber(value: 0.5),
                        NSNumber(value: 0.8),
                        NSNumber(value: 1.0)]
        
        //线性 kCAAnimationLinear linear
        let keyFrameAni = Animate.keyFrameAnimationWithKeyPath("position", values: values, keyTimes: keyTimes, path: nil, duration: 4, cacluationMode: kCAAnimationLinear, rotationMode: "auto")
        
        //跳跃的形式 kCAAnimationDiscrete discrete
//        let keyFrameAni = Animate.keyFrameAnimationWithPath("position", values: values, keyTimes: keyTimes, path: nil, duration: 4, cacluationMode: kCAAnimationDiscrete, rotationMode: "auto")
        
        //圆滑效果 kCAAnimationCubic cubic
//        let keyFrameAni = Animate.keyFrameAnimationWithPath("position", values: values, keyTimes: keyTimes, path: nil, duration: 4, cacluationMode: kCAAnimationCubic, rotationMode: "auto")
        keyFrameAni.repeatCount = Float.infinity
        
        ImgView.layer.add(keyFrameAni, forKey: "position")
        
        view.layer.addSublayer(rectLayer)
    }
    
    @IBAction func circle(_ sender: Any) {
        
        rectLayer.removeFromSuperlayer()
        
        ImgView.layer.removeAllAnimations()
        
        
        let keyFrameAni = Animate.keyFrameAnimationWithKeyPath("position", values: nil, keyTimes: nil, path: circlePath, duration: 4, cacluationMode: kCAAnimationCubicPaced, rotationMode: "auto")
        keyFrameAni.repeatCount = Float.infinity
        
        ImgView.layer.add(keyFrameAni, forKey: "circleAnimation")
        
        view.layer.addSublayer(circleLayer)
    }
}
