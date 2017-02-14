//
//  PQButton.swift
//  Animate
//
//  Created by Mac on 17/2/9.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

//#define PQ_RADIANS(number)  ((PQ_PI * number)/ 180)
func radius(_ angle : CGFloat) -> CGFloat{
    return (3.14159265359 * angle) / 180.0
}
class PQButton: UIButton {
    var myTitle: String = ""
    
    var isStopLoginingAni : Bool = false{
        didSet{
            if isStopLoginingAni {
                //停止动画
                aniLayer4.removeFromSuperlayer()
                
                //重新设置borderWidth
                layer.borderWidth = 2
                print("myTitle = " + myTitle)
                setTitle(myTitle, for: .normal)
            }
        }
    }
    
    //第一个动画的key
    let ani1 = "ani1PathAnimation"
    let ani2 = "ani2PathAnimation"
    let ani3 = "ani3PathAnimation"
    
    let ani1Duration : Double = 0.35
    let ani2Duration : Double = 0.4
    let ani3Duration : Double = 0.25
    
    //定义一个block回调
    typealias PQButtonClickBlock = ( (_ button :PQButton) -> () )
    
    fileprivate func setupUI(){
        
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = bounds.height * 0.5
//        layer.masksToBounds = true
        
        addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
    }
    
    @objc fileprivate func buttonClick(_ button : PQButton){
        guard let block = clickEvent else {
            return
        }
        block(button)
        
        //添加动画1
        addAnimation1()
    }
    
    func touchUpInSideEvent(_ click : PQButtonClickBlock?){
        clickEvent = click
    }
    
    fileprivate func addAnimation1(){
        layer.addSublayer(aniLayer1)
        //动画一
        let ani1Path = Animate.baseAnimationWithKeyPath("path", fromValue: drawPathSize(CGSize(width: 0 , height: 0) , cornerRadius: 0), toValue: drawPathSize(CGSize(width: 30 , height: 30) , cornerRadius: 15), duration: ani1Duration, repeatCount: 0, timingFunction: kCAMediaTimingFunctionEaseOut)
        ani1Path.delegate = self
        ani1Path.isRemovedOnCompletion = false
        
        aniLayer1.add(ani1Path, forKey: ani1)
    }
    
    fileprivate func addAnimation2(){
        layer.addSublayer(aniLayer2)
        
        //动画二 - 路径
        let ani2Path = Animate.baseAnimationWithKeyPath("path", fromValue: drawPathSize(CGSize(width: 30 , height: 30) ,cornerRadius: 15), toValue: drawPathSize(CGSize(width: 60 , height: 60) ,cornerRadius: 30), duration: ani2Duration, repeatCount: nil, timingFunction: kCAMediaTimingFunctionEaseIn)
        
        //动画二 - 不透明度
        let ani2Opacity = Animate.baseAnimationWithKeyPath("opacity", fromValue: NSNumber(value: 1), toValue: NSNumber(value: 0.1), duration: ani2Duration, repeatCount: 0, timingFunction: kCAMediaTimingFunctionEaseIn)
        
        //动画二 - 边框
        let ani2LineWidth = Animate.baseAnimationWithKeyPath("lineWidth", fromValue: nil, toValue: 15, duration: ani2Duration, repeatCount: nil, timingFunction: nil)
        
        //group
        let ani2Group = CAAnimationGroup()
        ani2Group.delegate = self
        ani2Group.animations = [ani2Path,ani2Opacity,ani2LineWidth]
        ani2Group.duration = 0.5
        ani2Group.isRemovedOnCompletion = false
        
        aniLayer2.add(ani2Group, forKey: ani2)
    }
    
    fileprivate func addAnimation3(){
        layer.addSublayer(aniLayer3)
        let ani3Path = Animate.baseAnimationWithKeyPath("path", fromValue: drawPathSize(CGSize(width: 20 , height: bounds.height) , cornerRadius: bounds.height * 0.5), toValue: drawPathSize(bounds.size , cornerRadius: bounds.height * 0.5), duration: ani2Duration, repeatCount: nil, timingFunction: nil)
        ani3Path.isRemovedOnCompletion = false
        ani3Path.delegate = self
        aniLayer3.add(ani3Path, forKey: ani3)
    }
    
    fileprivate func addAnimation4(){
        layer.addSublayer(aniLayer4)
       
        let ani3Rotation = Animate.baseAnimationWithKeyPath("transform.rotation.z", fromValue: nil, toValue: M_PI * 2, duration: 0.5, repeatCount: Float.infinity, timingFunction: "linear")
        aniLayer4.add(ani3Rotation, forKey: ani3)
    }
    
    fileprivate func drawCirclePath(startAngle:CGFloat , endAngle:CGFloat) -> CGPath{
        let path = UIBezierPath(arcCenter: CGPoint(x:(self.bounds.width - self.bounds.height * 0.4 * 2) * 0.5,y:self.bounds.height * 0.4), radius: self.bounds.height * 0.6, startAngle: radius(startAngle), endAngle: radius(endAngle), clockwise: true).cgPath
        return path
    }
    
    fileprivate func drawPathSize(_ size : CGSize , cornerRadius : CGFloat) -> CGPath{
        let center = CGPoint(x: (self.bounds.width - size.width) * 0.5, y: (self.bounds.height - size.height) * 0.5)
        let path = UIBezierPath(roundedRect: CGRect(origin: center, size: size), cornerRadius: cornerRadius).cgPath
        return path
    }
    
    //记录当前的title
    override func setTitle(_ title: String?, for state: UIControlState) {
        super.setTitle(title, for: state)
        let str = titleLabel?.text ?? ""
        if str.characters.count > 0 {
            myTitle = str
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let str = titleLabel?.text ?? ""
        if str.characters.count > 0 {
            myTitle = str
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    //单击事件回调
    fileprivate var clickEvent : PQButtonClickBlock?
    
    
    
    //动画一
    lazy var aniLayer1 : CAShapeLayer = {
        let layer = CAShapeLayer()
        //大小
        layer.frame = self.bounds
        //填充颜色
        layer.fillColor = UIColor.white.cgColor
        return layer
    }()
    //动画二
    fileprivate lazy var aniLayer2 : CAShapeLayer = {
        let layer = CAShapeLayer()
        //大小
        layer.frame = self.bounds
        //填充颜色
        layer.fillColor = UIColor.clear.cgColor
        //边框颜色
        layer.strokeColor = UIColor.white.cgColor
        //边框宽度
        layer.lineWidth = 8
        return layer
    }()
    //动画三
    fileprivate lazy var aniLayer3 : CAShapeLayer = {
        let layer = CAShapeLayer()
        //大小
        layer.frame = self.bounds
        //填充颜色
        layer.fillColor = UIColor(white: 1, alpha: 0.6).cgColor
        return layer
    }()
    //动画四
    fileprivate lazy var aniLayer4 : CAShapeLayer = {
        let layer = CAShapeLayer()
        //填充颜色
        layer.fillColor = UIColor.clear.cgColor
        //边框颜色
        layer.strokeColor = UIColor.white.cgColor
        //边框宽度
        layer.lineWidth = 3
        layer.position = CGPoint(x: (self.bounds.width - self.bounds.height * 0.5) * 0.5, y: self.bounds.height * 0.5)
        
        //UIBezierPath:arc...
        /*
         arcCenter:半径
         radius:角度
         startAngle:开始角度
         endAngle:结束角度
         clockWise:顺/逆时针
         */
        let ra = self.bounds.size.height/2 - 3
        layer.path = UIBezierPath(arcCenter: CGPoint(x: 0 ,y: 0), radius: ra, startAngle: radius(0), endAngle: radius(60), clockwise: true).cgPath
        
        return layer
    }()
}

extension PQButton : CAAnimationDelegate{
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool){
        if anim == aniLayer1.animation(forKey: ani1){
            //延时 0.1s 移除，衔接动画
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
                self.aniLayer1.removeFromSuperlayer()
            })
            //添加第二个动画
            addAnimation2()
            
            print("comming... 1")
        }
        
        if anim == aniLayer2.animation(forKey: ani2) {
            aniLayer2.removeFromSuperlayer()
            addAnimation3()
            print("comming... 2")
        }
        
        if anim == aniLayer3.animation(forKey: ani3)  {
            aniLayer3.removeFromSuperlayer()
            
            layer.borderWidth = 0;
            setTitle(nil, for: .normal)
            
            //开始动画4
            addAnimation4()
            print("comming... 3")
        }
    }
}
