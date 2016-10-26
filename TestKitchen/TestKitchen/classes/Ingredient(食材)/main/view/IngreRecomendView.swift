//
//  IngreRecomendView.swift
//  TestKitchen
//
//  Created by qianfeng on 16/10/25.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

//定义食材首页widget列表的类型
public enum IngreWidgetType: Int {
    case GuessYouLike = 1 //猜你喜欢
    case RedPacket = 2 //红包入口
    
}



class IngreRecomendView: UIView {
    
    var jumpClosure: IngreJumpClosure?
    
    //数据
    var model: IngreRecommondModel! {
        didSet {
            // set方法调用之后会调用这里的方法
            tbView.reloadData()
        }
    }
    //表格
    private var tbView: UITableView!
    //重新实现初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 创建表格视图
        tbView = UITableView(frame: CGRectZero, style: .Plain)
        tbView.delegate = self
        tbView.dataSource = self
        addSubview(tbView)
//        tbView.backgroundColor = UIColor.blueColor()
//        tbView.registerNib(UINib(nibName: "IngreBannerCell", bundle: nil), forCellReuseIdentifier: "ingreBannerCellId")
        //约束
        tbView.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: UITableView代理
extension IngreRecomendView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //banner广告部分显示一个分组
        var section = 1
        if model.data.widgetList.count > 0 {
            section += model.data.widgetList.count
        }
        
        return section
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row = 0
        if section == 0 {
            //广告
            row = 1
        } else {
            //获取list对象
            let listModel = model.data.widgetList[section-1]
            if listModel.widget_type.integerValue == IngreWidgetType.GuessYouLike.rawValue || listModel.widget_type.integerValue == IngreWidgetType.RedPacket.rawValue {
                //猜你喜欢
                //红包入口
                row = 1
                
            }
            
        }
        
        
        return row
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //banner广告的高度为140
        var height: CGFloat = 0
        if indexPath.section == 0 {
            height = 140
        } else {
            let listModel = model.data.widgetList[indexPath.section - 1]
            if listModel.widget_type.integerValue == IngreWidgetType.GuessYouLike.rawValue {
                //猜你喜欢
                height = 70
                
            } else if listModel.widget_type.integerValue == IngreWidgetType.RedPacket.rawValue {
                    //红包入口
                    height = 75
            }
        }
        
        return height
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("ingreBannerCellId", forIndexPath: indexPath) as! IngreBannerCell
//        cell.bannerArray = model.data.bannerArray
        if indexPath.section == 0 {
            //banner广告
            let cell = IngreBannerCell.createBannerCellFor(tableView, atIndexPath: indexPath, bannerArray: model.data.bannerArray)
            //点击事件响应代码
            cell.jumpClosure = jumpClosure
            
            return cell

            
            
        } else {
            let listModel = model.data.widgetList[indexPath.section - 1]
            if listModel.widget_type.integerValue == IngreWidgetType.GuessYouLike.rawValue {
                //猜你喜欢
                let cell = IngreLikeCell.createLikeCellFor(tableView, atIndexPath: indexPath, listModel: listModel)
                cell.jumpClosure = jumpClosure
                
                return cell
            } else if listModel.widget_type.integerValue == IngreWidgetType.RedPacket.rawValue {
                //红包入口
                let cell = IngreRedPacketCell.createRedPacketCellFor(tableView, atIndexPath: indexPath, listModel: listModel)
                cell.jumpClosure = jumpClosure
                
                return cell
            }
            
        }
        
        
        return UITableViewCell()
        
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section > 0 {
            let listModel = model.data.widgetList[section - 1]
            if listModel.widget_type.integerValue == IngreWidgetType.GuessYouLike.rawValue {
                //猜你喜欢的分组的header
                let likeHeaderView = IngreLikeHeaderView(frame: CGRect(x: 0, y: 0, width: tbView.bounds.size.width, height: 44))
                return likeHeaderView
                
            }
        }
        return nil
    }
    //设置header的高度
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section > 0 {
            let listModel = model.data.widgetList[section - 1]
            if listModel.widget_type.integerValue == IngreWidgetType.GuessYouLike.rawValue {
                //猜你喜欢的分组的header的高度
                
                return 36
            }
        }

        return 0
    }
}









