//
//  GroupController.swift
//  Animate
//
//  Created by Mac on 17/2/8.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class GroupController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimation()
    }

    fileprivate func startAnimation(){
        
        //圆角
        let cornerRadiusAni = Animate.baseAnimationWithKeyPath("cornerRadius", fromValue: nil, toValue: 100, duration: 0.75, repeatCount: nil, timingFunction: nil)
        
        //边框宽度
        let borderWidthAni = Animate.baseAnimationWithKeyPath("borderWidth", fromValue: nil, toValue: 5, duration: 1.25, repeatCount: nil, timingFunction: nil)

        //边框颜色
        let borderColorAni = Animate.baseAnimationWithKeyPath("borderColor", fromValue: UIColor.clear.cgColor, toValue: UIColor.white.cgColor, duration: 1.0, repeatCount: nil, timingFunction: nil)
        
        //位移
        let positionYAni = Animate.baseAnimationWithKeyPath("position.y", fromValue: nil, toValue: 180, duration: 1.5, repeatCount: nil, timingFunction: nil)
        
        //大小
        let boundsAni = Animate.baseAnimationWithKeyPath("transform.scale", fromValue: 1, toValue: 0.75, duration: 1.6, repeatCount: nil, timingFunction: nil)
        
        //全部组合起来
        let groupAni = CAAnimationGroup()
        
        //动画数组
        groupAni.animations = [cornerRadiusAni,borderWidthAni,borderColorAni,positionYAni,boundsAni]
        
        //重复次数
        groupAni.repeatCount = Float.infinity
        
        //这里的时间一定要 ≥ 上面最长的动画时长
        groupAni.duration = 1.8
        
        //翻转huil
        groupAni.autoreverses = true
        
        imageView.layer.add(groupAni, forKey: "groupAnimation")
        
        //如果使用了cornerRadius之后那么shadow效果就会失效，解决方法就是创建一个Layer，添加上去
        
        //阴影位置
        let shadowOffsetAni = Animate.baseAnimationWithKeyPath("shadowOffset", fromValue: (cgSize: CGSize(width: -5, height: -5)), toValue: NSValue(cgSize: CGSize(width: 5, height: 5)), duration: 1, repeatCount: nil, timingFunction: nil)
        
        //阴影颜色
        let shadowColorAni = Animate.baseAnimationWithKeyPath("shadowColor", fromValue: nil, toValue: UIColor.darkGray.cgColor, duration: 1.5, repeatCount: nil, timingFunction: nil)
        
        //阴影不透明度
        let shadowOpacityAni = Animate.baseAnimationWithKeyPath("shadowOpacity", fromValue: 0, toValue: 0.7, duration: 1.25, repeatCount: nil, timingFunction: nil)
        
        //圆角
        let shadowRadiusAni = Animate.baseAnimationWithKeyPath("shadowOpacity", fromValue: 2, toValue: 10, duration: 1.25, repeatCount: nil, timingFunction: nil)
        
        //创建新的layer
        let shapeLayer = CAShapeLayer()
        //设置大小
        shapeLayer.frame = imageView.frame
        //设置路径
        shapeLayer.path = CGPath(ellipseIn: imageView.bounds, transform: nil)
        
        
        
        //创建动画组
        let layerGroup = CAAnimationGroup()
        
        //添加动画
        layerGroup.animations = [shadowColorAni,shadowOffsetAni,shadowRadiusAni,shadowOpacityAni,positionYAni,boundsAni]
        
        //重复次数
        layerGroup.repeatCount = Float.infinity
        
        //动画时间
        layerGroup.duration = 1.8
        
        //翻转
        layerGroup.autoreverses = true
        
        //把层添加进去
        view.layer.insertSublayer(shapeLayer, at : 0)
        
        //添加动画
        shapeLayer.add(layerGroup, forKey: "layerGroup")
        
        
    }
    
}
