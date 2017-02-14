//
//  PQTransition.swift
//  Animate
//
//  Created by Mac on 17/2/13.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit
//动画类型
enum PQTransitionType : Int {
    case transfrom = 0
    case animation = 1
}

class PQTransition: NSObject,UIViewControllerTransitioningDelegate{
    
    var animationType : PQTransitionType = .transfrom
    
    /// 转场动画时间
    lazy var duration : Double = 0.5
    
    /// 是不是present
    lazy var isPresent : Bool = true
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        isPresent = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        isPresent = false
        return self
    }
    
    //设置显示出来的ViewController的大小的，这里不用
    //    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?{}
    
}

//转场动画代理
extension PQTransition:UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval{
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
        
        if animationType == .transfrom {
            //transfrom 动画
            transfromAnimation(using: transitionContext)
        }else{
            //CAAnimation 动画
            isPresent ? showController(using: transitionContext) : closeController(using: transitionContext)
        }
        
        
    }
    
    func transfromAnimation(using transitionContext: UIViewControllerContextTransitioning){
        // 1、获取到要展现的视图
        let toView = transitionContext.viewController(forKey: .to)!.view!
        let fromView = transitionContext.viewController(forKey: .from)!.view!
        
        // 2、把视图添加到容器上
        isPresent ? transitionContext.containerView.addSubview(toView) : transitionContext.containerView.addSubview(fromView)
        
        let snapVIew = !isPresent ? toView : fromView
        
        let tImageView = UIImageView(image:snapVIew.screenShot(rect: CGRect(x: 0, y: 0, width: fromView.bounds.width, height: fromView.bounds.height * 0.5)))
        let bImageView = UIImageView(image: snapVIew.screenShot(rect: CGRect(x: 0, y: fromView.bounds.height * 0.5, width: fromView.bounds.width, height: fromView.bounds.height)))
        bImageView.frame.origin.y = fromView.bounds.height * 0.5
        transitionContext.containerView.addSubview(tImageView)
        transitionContext.containerView.addSubview(bImageView)
        
        if !isPresent {
            tImageView.transform = tImageView.transform.translatedBy(x: 0, y: -fromView.bounds.height * 0.5)
            bImageView.transform = bImageView.transform.translatedBy(x: 0, y: fromView.bounds.height * 1.5)
        }
        
        // 3、执行动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            if self.isPresent {
                tImageView.transform = tImageView.transform.translatedBy(x: 0, y: -fromView.bounds.height * 0.5)
                bImageView.transform = bImageView.transform.translatedBy(x: 0, y: fromView.bounds.height * 1.5)
            }else{
                tImageView.transform = CGAffineTransform.identity
                bImageView.transform = CGAffineTransform.identity
            }
        }) { (flag) in
            transitionContext.completeTransition(true)
        }
    }
    
    /// 处理显示controller动画
    ///
    /// - Parameter transitionContext: 上下文
    func showController(using transitionContext: UIViewControllerContextTransitioning){
        animationWayPresent(using: transitionContext)
    }
    
    /// 处理dismiss动画
    ///
    /// - Parameter transitionContext: 上下文
    func closeController(using transitionContext: UIViewControllerContextTransitioning){
        animationWayDimmiss(using: transitionContext)
    }
}



//动画代理
extension PQTransition : CAAnimationDelegate{
    
    func animationWayDimmiss(using transitionContext: UIViewControllerContextTransitioning){
        let fromView = transitionContext.viewController(forKey: .from)!.view!
        let toVC = (transitionContext.viewController(forKey: .to) as! UINavigationController)
        let toView =  (transitionContext.viewController(forKey: .to) as! UINavigationController).viewControllers.last!.view!
        
        let containerView = transitionContext.containerView
        containerView.insertSubview(toVC.view, at: 0)
        
        //找到button
        var button : PQButton? = nil
        for view in toView.subviews {
            if view is PQButton {
                button = view as? PQButton
            }
        }
        
        let maskLayer = CAShapeLayer()
        maskLayer.fillColor = UIColor.white.cgColor
        fromView.layer.mask = maskLayer
        let path1 = UIBezierPath(ovalIn: button?.frame ?? CGRect(x: 0, y: 0, width: 20, height: 20)).cgPath
        
        let path2 = UIBezierPath(arcCenter: containerView.center, radius: fromView.bounds.height , startAngle: 0, endAngle: CGFloat(M_PI * 2.0), clockwise: true).cgPath
        
        maskLayer.path = path1
        let animation = addAnimationTo(fromValue: path2, toValue: path1, transitionContext: transitionContext)
        maskLayer.add(animation, forKey: "presentAnimation")
    }
    
    func animationWayPresent(using transitionContext: UIViewControllerContextTransitioning){
        let fromView = (transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! UINavigationController).viewControllers.last!.view!
        let toView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!.view!
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        
        //找到button
        var button : PQButton? = nil
        for view in fromView.subviews {
            if view is PQButton {
                button = view as? PQButton
            }
        }
        
        let maskLayer = CAShapeLayer()
        maskLayer.fillColor = UIColor.darkGray.cgColor
        toView.layer.mask = maskLayer
        let path1 = UIBezierPath(ovalIn: button?.frame ?? CGRect(x: 0, y: 0, width: 20, height: 20)).cgPath
        
        let path2 = UIBezierPath(arcCenter: containerView.center, radius: fromView.bounds.height , startAngle: 0, endAngle: CGFloat(M_PI * 2.0), clockwise: true).cgPath
        
        maskLayer.path = path2
        let animation = addAnimationTo(fromValue: path1, toValue: path2, transitionContext: transitionContext)
        maskLayer.add(animation, forKey: "presentAnimation")
    }
    
    func addAnimationTo(fromValue : Any?, toValue : Any , transitionContext : UIViewControllerContextTransitioning) -> CAAnimation {
        let animation = Animate.baseAnimationWithKeyPath("path", fromValue: fromValue, toValue: toValue, duration: duration, repeatCount: nil, timingFunction: nil)
        animation.delegate = self
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        
        animation.setValue(transitionContext, forKey: "transitionContext")
        
        return animation
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool){
        if isPresent {
            let transitionContext = anim .value(forKey: "transitionContext") as! UIViewControllerContextTransitioning
            transitionContext.completeTransition(true)
            transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)?.view.layer.mask = nil
        }
        else if isPresent == false {
            let transitionContext = anim .value(forKey: "transitionContext") as! UIViewControllerContextTransitioning
            transitionContext.completeTransition(true)
            transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)?.view.layer.mask = nil
        }
    }
}
