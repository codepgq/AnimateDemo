//
//  TransitionController.swift
//  Animate
//
//  Created by Mac on 17/2/8.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

func arcRandom(_ random : UInt32) -> CGFloat{
    return CGFloat(arc4random() % random) / CGFloat(random)
}

let collectionViewCellKey = "TransitionAnimtionCell"
class TransitionController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var imgNamed = "icon2"
    let datas : [String] = ["fade","moveIn","push","reveal","cube", "suckEffect", "rippleEffect", "pageCurl", "pageUnCurl", "oglFlip", "cameraIrisHollowOpen",  "cameraIrisHollowClose", "spewEffect","genieEffect","unGenieEffect","twist","tubey","swirl","charminUltra", "zoomyIn", "zoomyOut", "oglApplicationSuspend"]
    
    let derection : [String] = [kCATransitionFromRight,kCATransitionFromLeft,kCATransitionFromTop,kCATransitionFromBottom]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionViewCellKey)
    }
    
    
    @IBAction func segMentValueChange(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
    }
    
    func startTransitionAnimate(type : String){
        
        imgView.layer.removeAllAnimations()
        
        let derectionStr = derection[segment.selectedSegmentIndex]
        
        let transitionAni = Animate.transitionAnimationWith(0.75, type: type, subtype: derectionStr, startProgress: 0, endProgress: 1)
        imgView.image = UIImage(named: imgNamed)
        
        imgView.layer.add(transitionAni, forKey: "transition")
        
        //改变图片的名称
        imgNamed = (imgNamed == "icon1") ? "icon2" : "icon1"
    }

}

// MARK - CollectionView
extension TransitionController: UICollectionViewDelegate,UICollectionViewDataSource{
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return datas.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellKey, for: indexPath)
        
        cell.backgroundColor = randomColor()
        
        let lbl = UILabel(frame: cell.contentView.bounds)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.text = datas[indexPath.item]
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor.white
        
        cell.contentView.addSubview(lbl)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        startTransitionAnimate(type: datas[indexPath.item])
    }
    
    
    func randomColor() -> UIColor{
        return UIColor(red: arcRandom(255), green: arcRandom(255), blue: arcRandom(255), alpha: 1)
    }
}
