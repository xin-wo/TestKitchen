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
    case TodayNew = 5 //今日新品
    case Scene = 3 //早餐日记等
    case SceneList = 9 //全部场景
    case Talnet = 4 //推荐达人
    case Post = 8 //精选作品
    case Topic = 7 //美食专题
}



class IngreRecomendView: UIView {
    
    var jumpClosure: IngreJumpClosure?
    
    //数据
    var model: IngreRecommondModel? {
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
        tbView?.snp_makeConstraints {
            (make) in
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
        
        if model?.data.widgetList.count > 0 {
            section += model!.data.widgetList.count
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
            let listModel = model!.data.widgetList[section-1]
            if listModel.widget_type.integerValue == IngreWidgetType.GuessYouLike.rawValue || listModel.widget_type.integerValue == IngreWidgetType.RedPacket.rawValue || listModel.widget_type.integerValue == IngreWidgetType.TodayNew.rawValue || listModel.widget_type.integerValue == IngreWidgetType.Scene.rawValue || listModel.widget_type.integerValue == IngreWidgetType.SceneList.rawValue || listModel.widget_type.integerValue == IngreWidgetType.Post.rawValue {
                //猜你喜欢
                //红包入口
                //早餐日记
                //全部场景
                //精选作品
                row = 1
                
            } else if listModel.widget_type.integerValue == IngreWidgetType.Talnet.rawValue {
                //推荐达人
                row = listModel.widget_data.count / 4
            } else if listModel.widget_type.integerValue == IngreWidgetType.Topic.rawValue {
                //美食专题
                row = listModel.widget_data.count/3
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
            let listModel = model!.data.widgetList[indexPath.section - 1]
            if listModel.widget_type.integerValue == IngreWidgetType.GuessYouLike.rawValue {
                //猜你喜欢
                height = 70
                
            } else if listModel.widget_type.integerValue == IngreWidgetType.RedPacket.rawValue {
                    //红包入口
                    height = 75
            } else if listModel.widget_type.integerValue == IngreWidgetType.TodayNew.rawValue {
                //今日新品
                height = 280
            } else if listModel.widget_type.integerValue == IngreWidgetType.Scene.rawValue {
                //早餐日记等
                height = 200
            } else if listModel.widget_type.integerValue == IngreWidgetType.SceneList.rawValue {
                //全部场景
                height = 60
            } else if listModel.widget_type.integerValue == IngreWidgetType.Talnet.rawValue {
                //推荐达人
                height = 80
            } else if listModel.widget_type.integerValue == IngreWidgetType.Post.rawValue {
                //精选作品
                height = 180
            } else if listModel.widget_type.integerValue == IngreWidgetType.Topic.rawValue {
                //美食专题
                height = 120
            }
        }
        
        return height
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("ingreBannerCellId", forIndexPath: indexPath) as! IngreBannerCell
//        cell.bannerArray = model.data.bannerArray
        if indexPath.section == 0 {
            //banner广告
            let cell = IngreBannerCell.createBannerCellFor(tableView, atIndexPath: indexPath, bannerArray: model?.data.bannerArray)
            //点击事件响应代码
            cell.jumpClosure = jumpClosure
            
            return cell

            
            
        } else {
            let listModel = model!.data.widgetList[indexPath.section - 1]
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
            }  else if listModel.widget_type.integerValue == IngreWidgetType.TodayNew.rawValue {
                //今日新品入口
                let cell = IngreTodayCell.createTodayCellFor(tableView, atIndexPath: indexPath, listModel: listModel)
                cell.jumpClosure = jumpClosure
                
                return cell
            } else if listModel.widget_type.integerValue == IngreWidgetType.Scene.rawValue {
                //早餐日记等
                let cell = IngreSceneCell.createSceneCellFor(tableView, atIndexPath: indexPath, listModel: listModel)
                cell.jumpClosure = jumpClosure
                
        
                
                return cell
            } else if listModel.widget_type.integerValue == IngreWidgetType.SceneList.rawValue {
                let cell = IngreSceneListCell.createSceneListCellFor(tableView, atIndexPath: indexPath, listModel: listModel)
                cell.jumpClosure = jumpClosure
                
                
                cell.listModel = listModel
                return cell
            } else if listModel.widget_type.integerValue == IngreWidgetType.Talnet.rawValue {
                
                //获取子数组
                let range = NSMakeRange(indexPath.row*4, 4)
                
                let array = NSArray(array: listModel.widget_data).subarrayWithRange(range) as! [IngreRecommendWidgetData]
                
                
                let cell = IngreTalnetCell.createTalnetCellFor(tableView, atIndexPath: indexPath, cellArray: array)
                cell.jumpClousure = jumpClosure
                
                
              return cell
            } else if listModel.widget_type.integerValue == IngreWidgetType.Post.rawValue {
                let cell = IngrePostCell.createPostCellFor(tableView, atIndexPath: indexPath, listModel: listModel)
                cell.jumpClosure = jumpClosure
                
                return cell
            
            } else if listModel.widget_type.integerValue == IngreWidgetType.Topic.rawValue {
                
                let range = NSMakeRange(indexPath.row*3, 3)
                
                let cellArray = NSArray(array: listModel.widget_data).subarrayWithRange(range) as! [IngreRecommendWidgetData]
                
                //美食专题
                let cell = IngreTopicCell.createTopicCellFor(tableView, atIndexPath: indexPath, cellArray: cellArray)
                cell.jumpClosure = jumpClosure
                
                return cell
                
            }
        }
        
        
        return UITableViewCell()
        
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section > 0 {
            let listModel = model!.data.widgetList[section - 1]
            if listModel.widget_type.integerValue == IngreWidgetType.GuessYouLike.rawValue {
                //猜你喜欢的分组的header
                let likeHeaderView = IngreLikeHeaderView(frame: CGRect(x: 0, y: 0, width: tbView.bounds.size.width, height: 44))
                return likeHeaderView
                
            } else if listModel.widget_type.integerValue == IngreWidgetType.TodayNew.rawValue || listModel.widget_type.integerValue == IngreWidgetType.Scene.rawValue || listModel.widget_type.integerValue == IngreWidgetType.Talnet.rawValue || listModel.widget_type.integerValue == IngreWidgetType.Post.rawValue || listModel.widget_type.integerValue == IngreWidgetType.Topic.rawValue {
                //早餐日记等
                //今日新品
                //推荐达人
                //精选作品
                //美食专题
                let headerView = IngreHeaderView(frame: CGRectMake(0, 0, kScreenWidth, 54))
                headerView.configText(listModel.title)
                headerView.jumpClosure = jumpClosure
                headerView.listModel = listModel
                return  headerView
            }
        
        }
        return nil
    }
    //设置header的高度
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section > 0 {
            let listModel = model!.data.widgetList[section - 1]
            if listModel.widget_type.integerValue == IngreWidgetType.GuessYouLike.rawValue {
                //猜你喜欢的分组的header的高度
                
                return 36
            } else if listModel.widget_type.integerValue == IngreWidgetType.TodayNew.rawValue || listModel.widget_type.integerValue == IngreWidgetType.Scene.rawValue || listModel.widget_type.integerValue == IngreWidgetType.Talnet.rawValue || listModel.widget_type.integerValue == IngreWidgetType.Post.rawValue || listModel.widget_type.integerValue == IngreWidgetType.Topic.rawValue {
                //今日新品
                //早餐日记等
                //推荐达人
                //精选作品
                //美食专题
                return 54
            }
        }

        return 0
    }
    
    //去掉UITableView的粘滞性
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let h: CGFloat = 54
        
        if scrollView.contentOffset.y >= h {
            scrollView.contentInset = UIEdgeInsetsMake(-h, 0, 0, 0)
        } else if scrollView.contentOffset.y > 0 {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0)
        }
        
    }
    
}









