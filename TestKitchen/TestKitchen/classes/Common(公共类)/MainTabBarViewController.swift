//
//  MainTabBarViewController.swift
//  TestKitchen
//
//  Created by qianfeng on 16/10/21.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit
import SnapKit

class MainTabBarViewController: UITabBarController {
    
    //tabBar的背景
    private var bgView: UIView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1.创建背景视图
        bgView = UIView.createView()
        //设置边框
        bgView?.layer.borderColor = UIColor.blackColor().CGColor
//        bgView?.layer.borderWidth = 1
        view.addSubview(bgView!)
        bgView?.backgroundColor = UIColor(white: 0.9, alpha: 1)
        
        
        
        
        bgView?.snp_makeConstraints(closure: { [weak self] (make) in
            make.left.right.bottom.equalTo((self?.view)!)
            make.height.equalTo(49)
        })
        
        //隐藏系统的tabBar
        tabBar.hidden = true
        
        //创建视图控制器
        createViewControllers()
        
        //自定制tabbar
        createMytabar()
        
       
    }
    //自定制tabbar
    func createMytabar() {
        // 图片名字
        let imageNames = ["home", "community", "shop", "shike", "mine"]
        // 标题
        let titles = ["食材","社区","商城","食课","我的"]
        // 循环创建按钮
        let width = kScreenWidth/CGFloat(imageNames.count)
        for i in 0..<imageNames.count {
            let imageName = imageNames[i] + "_normal"
            let selectName = imageNames[i] + "_select"
            let btn = UIButton.createButton(nil, bgImageName: imageName, hightLightImageName: nil, selectImageName: selectName, target: self, action: #selector(btnClick(_:)))
            if i == 0 {
                btn.selected = true
                btn.userInteractionEnabled = false
            }
            
            bgView!.addSubview(btn)
            
            //设置位置
            btn.snp_makeConstraints(closure: { [weak self] (make) in
                make.top.bottom.equalTo((self?.bgView)!)
                make.width.equalTo(width)
                make.left.equalTo(width*CGFloat(i))
            })
            //显示标题
            let titleLabel = UILabel.createLabel(titles[i], textAlignment: .Center, font: UIFont.systemFontOfSize(10))
            //设置tag
            btn.tag = 300 + i
            
            btn.addSubview(titleLabel)
            //设置位置
            titleLabel.snp_makeConstraints(closure: { [weak self] (make) in
                make.left.right.bottom.equalTo(btn)
                make.height.equalTo(20)
            })
            
            
            
        }
        
        
        
    }
    
    
    func btnClick(btn: UIButton) {
        let index = btn.tag - 300
        
        // 取消选中之前的按钮
        let lastBtn = bgView?.viewWithTag(300+selectedIndex) as! UIButton
        lastBtn.selected = false
        lastBtn.userInteractionEnabled = true
        
        // 选中当前的按钮
        
        btn.selected = true
        btn.userInteractionEnabled = false
        
        // 切换视图控制器
        selectedIndex = index
        
        
    }
    
    //创建视图控制器
    func createViewControllers() {
        let nameArray = ["TestKitchen.IngredientViewController","TestKitchen.CommunityViewController","TestKitchen.MallViewController","TestKitchen.FoodClassViewController","TestKitchen.ProfileViewController"]
        
    
        //视图控制器对象的数组
        var ctrlArray = Array<UINavigationController>()
        for i in 0..<nameArray.count {
            
            let name = nameArray[i]
            
            //使用类名创建类的对象
            let ctrl = NSClassFromString(name) as! UIViewController.Type
            let vc = ctrl.init()
            
            let navCtrl = UINavigationController(rootViewController: vc)
            ctrlArray.append(navCtrl)

        }
        viewControllers = ctrlArray
        
        
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
