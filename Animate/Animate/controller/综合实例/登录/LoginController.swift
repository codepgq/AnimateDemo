//
//  LoginController.swift
//  Animate
//
//  Created by Mac on 17/2/9.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class LoginController: BaseViewController {

    @IBOutlet weak var backImageView: UIImageView!
    
    @IBOutlet weak var button: PQButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startTimer()
        
        button.touchUpInSideEvent { (button) in
            print("点击了我")
            
            //模仿登录失败
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3, execute: { 
                self.button.isStopLoginingAni = true
            })
        }
    }
    

    @objc fileprivate func chageBackImg(){
        //rippleEffect  rippleEffect                    
        let transitionAni = Animate.transitionAnimationWith(duration: 1.25, type: "rippleEffect", subtype: nil, startProgress: 0, endProgress: 1)
        backImageView.image = UIImage(named: imgNamed)
        backImageView.layer.add(transitionAni, forKey: "rippleEffect")
        
        imgNamed = (imgNamed == "bizhi") ? "bizhi2" : "bizhi"
    }

    @IBAction func loginBtn(_ sender: UIButton) {
        
    }
    
    
    
    func startTimer(){
        changImgTimer = createTimer()
    }
    
    func createTimer() -> Timer{
        let timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(chageBackImg), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)
        return timer
    }

    lazy var changImgTimer : Timer = Timer()
    var imgNamed : String = "bizhi2"
        
}
