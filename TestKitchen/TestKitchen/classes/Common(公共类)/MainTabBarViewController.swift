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
        
        //创建视图控制器
        createViewControllers()
     

        
       
    }
    //自定制tabbar
    func createMytabBar(imageNames: Array<String>, titles: Array<String>) {
//        // 图片名字
//        let imageNames = ["home", "community", "shop", "shike", "mine"]
//        // 标题
//        let titles = ["食材","社区","商城","食课","我的"]
        // 循环创建按钮
        let width = kScreenWidth/CGFloat(imageNames.count)
        for i in 0..<imageNames.count {
            let imageName = imageNames[i] + "_normal"
            let selectName = imageNames[i] + "_select"
            let btn = UIButton.createButton(nil, bgImageName: imageName, hightLightImageName: nil, selectImageName: selectName, target: self, action: #selector(btnClick(_:)))
           
            
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
            titleLabel.textColor = UIColor.lightGrayColor()
            titleLabel.tag = 400
            btn.addSubview(titleLabel)
            //设置位置
            titleLabel.snp_makeConstraints(closure: { (make) in
                make.left.right.bottom.equalTo(btn)
                make.height.equalTo(20)
            })
            
            if i == 0 {
                btn.selected = true
                btn.userInteractionEnabled = false
                titleLabel.textColor = UIColor.brownColor()
            }
            
        }
        
        
        
    }
    
    
    func btnClick(btn: UIButton) {
        let index = btn.tag - 300
        
        // 取消选中之前的按钮
        let lastBtn = bgView?.viewWithTag(300+selectedIndex) as! UIButton
        lastBtn.selected = false
        lastBtn.userInteractionEnabled = true
        let lastLabel = lastBtn.viewWithTag(400) as! UILabel
        lastLabel.textColor = UIColor.lightGrayColor()
        
        // 选中当前的按钮
        
        btn.selected = true
        btn.userInteractionEnabled = false
        let curLabel = btn.viewWithTag(400) as! UILabel
        curLabel.textColor = UIColor.brownColor()
        
        // 切换视图控制器
        selectedIndex = index
        
        
    }
    
    //创建视图控制器
    func createViewControllers() {
        
        //从controller.json文件里面读取数据
        let path = NSBundle.mainBundle().pathForResource("Controllers", ofType: "json")
        let data = NSData(contentsOfFile: path!)
        //视图控制器名字的数组
        var nameArray = [String]()
        //图片名字
        var images = [String]()
        //标题文字
        var titles = [String]()
        
        
        do {
            //可能抛出异常的代码写这
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
            if json.isKindOfClass(NSArray) {
                
                let tmpArray = json as! Array<Dictionary<String,String>>
                //遍历获取视图控制器的名字
                for tmpDict in tmpArray {
                    let name = tmpDict["ctrlname"]
                    nameArray.append(name!)
                    //图片
                    let imageName = tmpDict["image"]
                    images.append(imageName!)
                    //标题
                    let title = tmpDict["title"]
                    titles.append(title!)
                    
                    
                }
            }
        } catch (let error) {
            //捕获错误信息
            print(error)
        }
        
       
        
        //视图控制器对象的数组
        var ctrlArray = Array<UINavigationController>()
        for i in 0..<nameArray.count {
            
            let name = "TestKitchen."+nameArray[i]
            
            //使用类名创建类的对象
            let ctrl = NSClassFromString(name) as! UIViewController.Type
            let vc = ctrl.init()
            
            let navCtrl = UINavigationController(rootViewController: vc)
            ctrlArray.append(navCtrl)

        }
        viewControllers = ctrlArray
        //隐藏系统的tabBar
        tabBar.hidden = true
        
        //自定制tabbar
        createMytabBar(images, titles: titles)
        
    }
    
    //显示tabBar
    func showTabBar() {
        UIView.animateWithDuration(0.25) { 
            self.bgView?.hidden = false
        }
    }
    //隐藏tabBar
    func hideTabBar() {
        UIView.animateWithDuration(0.25) { 
            self.bgView?.hidden = true
        }
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
