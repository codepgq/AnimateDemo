//
//  WaveLineController.swift
//  Animate
//
//  Created by Mac on 17/2/8.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class WaveLineController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let waveLineView = WaveLineView(frame: view.bounds)
        view.addSubview(waveLineView)
    }

}
