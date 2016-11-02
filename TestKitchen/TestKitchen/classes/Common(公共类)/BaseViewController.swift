//
//  BaseViewController.swift
//  TestKitchen
//
//  Created by qianfeng on 16/10/21.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

/*
 试图控制器的公共父类
 用来封装一些共有的代码
 
 */


class BaseViewController: UIViewController {

    //导航上面添加按钮
    func addNavBtn(imageName: String, target: AnyObject?, action: Selector, isleft: Bool) {
        let btn = UIButton.createButton(nil, bgImageName: imageName, hightLightImageName: nil, selectImageName: nil, target: target, action: action)
        btn.frame = CGRectMake(0, 0, 44, 44)
        let barBtn = UIBarButtonItem(customView: btn)
        if isleft {
            //左边按钮
            navigationItem.leftBarButtonItem = barBtn
        } else {
            //右边按钮
            navigationItem.rightBarButtonItem = barBtn
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置背景颜色
        view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
