//
//  IngreMaterialView.swift
//  TestKitchen
//
//  Created by qianfeng on 16/11/1.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class IngreMaterialView: UIView {
    
    //表格
    private var tableView: UITableView?
    
    //显示数据
    var model: IngreMaterial? {
        didSet {
            //刷新表格
            if model != nil {
                
                tableView?.reloadData()
                
            }
        }
    }
    
    
    override init(frame: CGRect) {
       super.init(frame: frame)
        //创建表格
        tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        addSubview(tableView!)
        
        tableView?.snp_makeConstraints(closure: { (make) in
            make.edges.equalTo(self)
        })
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}

extension IngreMaterialView: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row = 0
        if model?.data?.data?.count > 0 {
            row = (model?.data?.data?.count)!
        }
        
        return row
    }
    
    func  tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "IngreMaterialCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? IngreMaterialCell
        if nil == cell {
            cell = IngreMaterialCell(style: .Default, reuseIdentifier: cellId)
            
        }
        //显示数据
        cell?.cellModel = model?.data?.data![indexPath.row]
        return cell!

    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 700
    }
    
}


