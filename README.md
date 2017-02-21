# AnimateDemo
动画demo
在项目当中经常看到一些非常好看的动画，于是乎自己也利用了一下业余时间把这块东西整理

先看一个简单的结构图
![animation.png](http://upload-images.jianshu.io/upload_images/1940927-36cdda8548fef634.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

CAAnimation本身不能使用，需要使用他的子类。
- CAPropertyAnimation 属性动画 （本身也不能使用，要使用它的子类）
- CAAnimationGroup 组动画
- CATransition 转场动画，系统就是使用在这个来做转场动画效果处理的

### 一、CAPropertyAnimation之CABaseAnimaiton
因为CAAnimaiton是对`Layer`进行动画，属性动画顾名思义就是对`Layer`的属性进行动画。
在CABaseAnimation中常用的属性介绍：

> 
![属性介绍.png](http://upload-images.jianshu.io/upload_images/1940927-a21e2e8a76ebd428.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

<br />
####具有动画效果的KeyPath有
> 
![图片.png](http://upload-images.jianshu.io/upload_images/1940927-d5d44ddc9c86060f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


<br />
####代码如下：
```
class func baseAnimationWithKeyPath(_ path : String , fromValue : Any? , toValue : Any?, duration : CFTimeInterval, repeatCount : Float? , timingFunction : String?) -> CABasicAnimation{
        
        let animate = CABasicAnimation(keyPath: path)
        //起始值
        animate.fromValue = fromValue;
        
        //变成什么，或者说到哪个值
        animate.toValue = toValue
        
        //所改变属性的起始改变量 比如旋转360°，如果该值设置成为0.5 那么动画就从180°开始
        //        animate.byValue =
        
        //动画结束是否停留在动画结束的位置
        //        animate.isRemovedOnCompletion = false
        
        //动画时长
        animate.duration = duration
        
        //重复次数 Float.infinity 一直重复 OC：HUGE_VALF
        animate.repeatCount = repeatCount ?? 0
        
        //设置动画在该时间内重复
        //        animate.repeatDuration = 5
        
        //延时动画开始时间，使用CACurrentMediaTime() + 秒(s)
        //        animate.beginTime = CACurrentMediaTime() + 2;
        
        //设置动画的速度变化
        /*
        kCAMediaTimingFunctionLinear: String        匀速
        kCAMediaTimingFunctionEaseIn: String        先慢后快
        kCAMediaTimingFunctionEaseOut: String       先快后慢
        kCAMediaTimingFunctionEaseInEaseOut: String 两头慢，中间快
        kCAMediaTimingFunctionDefault: String       默认效果和上面一个效果极为类似，不易区分
         */
        
        animate.timingFunction = CAMediaTimingFunction(name: timingFunction ?? kCAMediaTimingFunctionEaseInEaseOut)
        
        
        //动画在开始和结束的时候的动作
        /*
         kCAFillModeForwards    保持在最后一帧，如果想保持在最后一帧，那么isRemovedOnCompletion应该设置为false
         kCAFillModeBackwards   将会立即执行第一帧，无论是否设置了beginTime属性
         kCAFillModeBoth        该值是上面两者的组合状态
         kCAFillModeRemoved     默认状态，会恢复原状
         */
        animate.fillMode = kCAFillModeBoth
        
        //动画结束时，是否执行逆向动画
        //        animate.autoreverses = true
        
        return animate
        
    }
```


实例图：
![aniChange.gif](http://upload-images.jianshu.io/upload_images/1940927-21964334111a0c25.gif?imageMogr2/auto-orient/strip)

![aniPosition.gif](http://upload-images.jianshu.io/upload_images/1940927-0b21f6a40400e9df.gif?imageMogr2/auto-orient/strip)


![aniRotation.gif](http://upload-images.jianshu.io/upload_images/1940927-a7d0f0b727f6e8a6.gif?imageMogr2/auto-orient/strip)


![aniScale.gif](http://upload-images.jianshu.io/upload_images/1940927-4af2f1ef7aef71c6.gif?imageMogr2/auto-orient/strip)

![aniSize.gif](http://upload-images.jianshu.io/upload_images/1940927-7188b67440e41381.gif?imageMogr2/auto-orient/strip)

<br />
###二、CAPropertyAnimation之CAKeyframeAnimation
关键帧动画属性介绍
>![图片.png](http://upload-images.jianshu.io/upload_images/1940927-1b023dbcf1620f84.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


<br />
###代码
```
class func keyFrameAnimationWithKeyPath(_ keyPath : String , values : [Any]? , keyTimes : [NSNumber]? , path : CGPath? , duration : CFTimeInterval , cacluationMode : String , rotationMode : String?) -> CAKeyframeAnimation{
        
        let keyFrame = CAKeyframeAnimation(keyPath: keyPath)
        
        //由关键帧（关键值），通过关键帧对应的值执行动画
        keyFrame.values = values
        
        //当设置了path之后，values就没有效果了
        keyFrame.path = path
        
        //计算模式
        /*
         `discrete', 离散的，不进行插值运算
         `linear',   线性插值
         `paced',    节奏动画，自动计算动画的运动时间，是的动画均匀运行，而不是根据keyTimes的值进行动画，设置这个模式keyTimes和timingFunctions无效
         `cubic'      对关键帧为坐标点的关键帧进行圆滑曲线相连后插值计算，需要设置timingFunctions。还可以通过tensionValues，continueityValues，biasValues来进行调整自定义
         `cubicPaced' 结合了paced和cubic动画效果
         */
        keyFrame.calculationMode = cacluationMode
        
        //旋转模式
        /*
         `auto' = kCAAnimationRotateAuto                根据路径自动旋转
         `autoReverse' = kCAAnimationRotateAutoReverse  根据路径自动翻转
         */
        keyFrame.rotationMode = rotationMode
        
        /*
         用来区分动画的分割时机。值区间为0.0 ~ 1.0 ，数组中的后一个值比前一个大或者相等，最好的是和Values或者Path控制的值对应
         这个属性只在 calculationMode = linear/discrete/cubic是被使用
         */
        keyFrame.keyTimes = keyTimes
        
        //动画时长
        keyFrame.duration = duration
        
        return keyFrame
        
    }
```

<br />
效果：
![aniKeyFrame.gif](http://upload-images.jianshu.io/upload_images/1940927-319aac343111e20d.gif?imageMogr2/auto-orient/strip)


三、组动画CAAnimationGroup
组动画是就是添加多个动画，同时产生动画效果
这个的属性比较简单：
- open var animations: [CAAnimation]?

代码
```
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
```

<br />
效果：
> ![aniGroup.gif](http://upload-images.jianshu.io/upload_images/1940927-d87bfb2c68e2274e.gif?imageMogr2/auto-orient/strip)

<br />
###四、CATransition转场动画
属性介绍

![图片.png](http://upload-images.jianshu.io/upload_images/1940927-a2352f0fa4ce8e36.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

代码
```
class func transitionAnimationWith(duration : CFTimeInterval, type : String , subtype : String? , startProgress : Float , endProgress : Float) -> CATransition{
        let transitionAni = CATransition()
        
        //转场类型
        transitionAni.type = type
        
        /*
         kCATransitionFromTop       从顶部转场
         kCATransitionFromBottom    从底部转场
         kCATransitionFromLeft      从左边转场
         kCATransitionFromRight     从右边转场
         */
        transitionAni.subtype = subtype ?? kCATransitionFromLeft
        
        //动画开始的进度
        transitionAni.startProgress = startProgress
        
        //动画结束的进度
        transitionAni.endProgress = endProgress
        
        //动画的时间
        transitionAni.duration = duration
        
        return transitionAni
    }
```

<br />
效果
![aniTransition.gif](http://upload-images.jianshu.io/upload_images/1940927-86c1ef696014caf4.gif?imageMogr2/auto-orient/strip)

###五、IOS9之后的 Spring动画

属性：
> 
![图片.png](http://upload-images.jianshu.io/upload_images/1940927-7604477da2df5a45.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


代码
```
class func springAnimationWithPath(_ path : String , mass : CGFloat , stiffness : CGFloat , damping : CGFloat , fromValue : Any? , toValue : Any) -> CASpringAnimation{
        let springAni = CASpringAnimation(keyPath: path)
        
        //质量：影响图层运动时的弹簧惯性，质量越大，弹簧的拉伸和压缩的幅度越大，动画的速度变慢，且波动幅度变大
        springAni.mass = mass
        
        //刚度：越大动画越快
        springAni.stiffness = stiffness
        
        //阻尼：越大停止越快
        springAni.damping = damping
        
        //初始速率
        springAni.initialVelocity = 0
        
        //初始值
        springAni.fromValue = fromValue
        
        //结束值
        springAni.toValue = toValue
        
        print("动画停止预估时间" + "\(springAni.settlingDuration)")
        
        springAni.duration = springAni.settlingDuration
        
        return springAni
    }
```

效果：
![aniSpring.gif](http://upload-images.jianshu.io/upload_images/1940927-b73cc6af074635ac.gif?imageMogr2/auto-orient/strip)

<br />
###六、综合实例
动画代码全部都在Git上面
![aniDrawline.gif](http://upload-images.jianshu.io/upload_images/1940927-dea7db2ef6dcd587.gif?imageMogr2/auto-orient/strip)

![aniFire1.gif](http://upload-images.jianshu.io/upload_images/1940927-c83672c56f1ffe6e.gif?imageMogr2/auto-orient/strip)

![aniFire2.gif](http://upload-images.jianshu.io/upload_images/1940927-0a7460e43c1a3bac.gif?imageMogr2/auto-orient/strip)


![aniLogin.gif](http://upload-images.jianshu.io/upload_images/1940927-6b3beae24c4240e6.gif?imageMogr2/auto-orient/strip)


![aniWaveLine.gif](http://upload-images.jianshu.io/upload_images/1940927-74834d17684a7894.gif?imageMogr2/auto-orient/strip)

<br />
- ##[DEMO地址](https://github.com/codepgq/AnimateDemo)
- ###如果觉得有用，用star砸死我吧

![图片.png](http://upload-images.jianshu.io/upload_images/1940927-9be2c036bbd410b2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
