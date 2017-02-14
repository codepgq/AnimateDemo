//
//  BaseViewController.swift
//  Animate
//
//  Created by Mac on 17/2/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow(noti:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    func keyboardShow(noti : Notification){
//        let rect : CGRect = (noti.userInfo! as! [String : Any])[UIKeyboardFrameBeginUserInfoKey] as! CGRect
//        viewTransformY(-(Float)(rect.size.height))
        
        let dict = (noti.userInfo as! [String : Any])
        let rect = (dict[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        viewTransformY(-(Float)(rect.size.height))
    }
    
    func viewTransformY(_ y : Float){
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.view.transform = CGAffineTransform(translationX: 0, y: CGFloat(y))
        }, completion: nil)
    }
    
    func hideKeyboard(){
        self.view.endEditing(true)
        viewTransformY(0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKeyboard()
    }
}
