//
//  LoginSuccessController.swift
//  Animate
//
//  Created by Mac on 17/2/13.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class LoginSuccessController: UIViewController {

    lazy var transition : PQTransition = {
        let trans = PQTransition()
        
        trans.duration = 0.5
        
        return trans
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        transitioningDelegate = transition
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.orange
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("121231")
        
        dismiss(animated: true, completion: nil)
    }

}

