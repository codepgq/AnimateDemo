//
//  WaveLineView.swift
//  Animate
//
//  Created by Mac on 17/2/8.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

/**
 正弦型函数解析式：y=Asin（ωx+φ）+h
 各常数值对函数图像的影响：
 φ（初相位）：决定波形与X轴位置关系或横向移动距离（左加右减）
 ω：决定周期（最小正周期T=2π/|ω|）
 A：决定峰值（即纵向拉伸压缩的倍数）
 h：表示波形在Y轴的位置关系或纵向移动距离（上加下减）
 */

class WaveLineView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        
        layer.masksToBounds = true
        
        setupUI()
    }
    
    fileprivate func setupUI(){
        //设置基本信息
        //水纹宽度
        waterWidth = bounds.width
        //波浪速度
        waveSpeed = 0.4 / CGFloat(M_PI)
        //设置波浪流动速度
        waveSpeed = 0.05
        //设置振幅
        waveA = 9
        //设置周期
        waveW = 2 * CGFloat(M_PI) / bounds.width
        //设置波浪纵向位置
        currentWaveK = bounds.height * 0.5
        
        //添加Layer
        layer.addSublayer(firstWaveLayer)
        layer.addSublayer(secondWaveLayer)
        layer.addSublayer(thirdWaveLayer)
        
        //开启定时器
        displayLink = CADisplayLink(target: self, selector: #selector(getCurrentWave(disPlayLink:)))
        displayLink.add(to: RunLoop.current, forMode: .commonModes)
    }
    
    func getCurrentWave(disPlayLink : CADisplayLink) {
        //实时位移
        offsetX += waveSpeed
        
        //设置路径
        setWavePath()
    }
    
    fileprivate func setWavePath(){
        firstWaveLayer.path = drawPath(offset: 0)
        secondWaveLayer.path = drawPath(offset: -waterWidth * 0.5)
        thirdWaveLayer.path = drawPath(offset: waterWidth * 0.8)
    }

    
    fileprivate func drawPath(offset : CGFloat) -> CGPath {
        let path = CGMutablePath()
        var y = currentWaveK
        
        path.move(to: CGPoint(x: 0, y: y))
        
        for i in 0...Int(waterWidth) {
            y = waveA * sin(waveW * CGFloat(i) + offsetX + offset) + currentWaveK
            path.addLine(to: CGPoint(x: CGFloat(i), y: y))
        }
        
        path.addLine(to: CGPoint(x: waterWidth, y: bounds.height))
        path.addLine(to: CGPoint(x: 0, y: bounds.height))
        path.closeSubpath()
        return path
    }
    
    
    //如果要显示两条波纹，就创建两个Layer显示，再通过CADisplayLink这个定时器进行快速绘制，从而达到波浪效果
    
    //波浪宽度
    var waveWidth : CGFloat = 0
    //波浪颜色
    var waveColor : UIColor = .green
    //水纹振幅
    var waveA : CGFloat = 1.0
    //水纹周期
    var waveW : CGFloat = 1 / 30.0
    //位移
    var offsetX : CGFloat = 0
    //当前波浪高度Y
    var currentWaveK : CGFloat = 0
    //水纹速度
    var waveSpeed : CGFloat = 0
    //水纹宽度
    var waterWidth : CGFloat = 0
    //定时器
    lazy var displayLink : CADisplayLink = CADisplayLink()
    //第一个Layer
    lazy var firstWaveLayer : CAShapeLayer = CAShapeLayer.createWithFillColor(UIColor(red: 55 / 255.0, green: 202 / 255.0, blue: 123 / 255.0, alpha: 0.5).cgColor)
    //第二个Layer
    lazy var secondWaveLayer : CAShapeLayer = CAShapeLayer.createWithFillColor(UIColor(red: 50 / 255.0, green: 200 / 255.0, blue: 110 / 255.0, alpha: 0.5).cgColor)
    //第三个Layer
    lazy var thirdWaveLayer : CAShapeLayer = CAShapeLayer.createWithFillColor(UIColor(red: 60 / 255.0, green: 230 / 255.0, blue: 120 / 255.0, alpha: 0.5).cgColor)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension CAShapeLayer {
    class func createWithFillColor(_ fillColor : CGColor) -> CAShapeLayer{
        let layer = CAShapeLayer()
        layer.fillColor = fillColor
        layer.strokeStart = 0.0
        layer.strokeEnd = 0.8
        return layer
    }
}
