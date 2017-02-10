//
//  ViewController.swift
//  Animate
//
//  Created by Mac on 17/2/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit
let identifierKey = "identifierKey"
class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let datas : [[String]] = [["Rotation","Position","Change","Scale","Size"],["KeyFrame"],["Transition"],["Spring"],["Group"],["DrawLine","WaveLine","Fire","FireTwo","Login"]]
    let titles : [String] = ["CABaseAnimation","CAKeyframeAnimation","TransitionAnimation","SpringAnimation","GroupAnimation","综合实例"]

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return datas[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titles[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var cell = tableView.dequeueReusableCell(withIdentifier: identifierKey)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifierKey)
        }
        
        cell?.textLabel?.text = datas[indexPath.section][indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let name = datas[indexPath.section][indexPath.row] + "Controller"
        let controller = stringToController(controller: name, nameSpace: "Animate")
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    ///把字符串转化为类
    private func stringToController(controller : String , nameSpace : String) -> UIViewController{
        //动态创建类，一定要包括 "命名空间." 比如 "PQWeiboDemo."
        let cls : AnyClass =
            NSClassFromString(String(nameSpace + "." + controller))!
        //类型指定
        let controller = cls as! UIViewController.Type
        //创建
        return controller.init()
    }
}

