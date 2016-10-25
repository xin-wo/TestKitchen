//
//  IngreRecomendView.swift
//  TestKitchen
//
//  Created by qianfeng on 16/10/25.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class IngreRecomendView: UIView {
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
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //banner广告部分显示一个分组
        return 1
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //banner广告的高度为140
        return 140
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("ingreBannerCellId", forIndexPath: indexPath) as! IngreBannerCell
//        cell.bannerArray = model.data.bannerArray
        let cell = IngreBannerCell.createBannerCellFor(tableView, atIndexPath: indexPath, bannerArray: model.data.bannerArray)
        
        
        return cell
        
    }
    
    
    
}









