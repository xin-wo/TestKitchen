//
//  IngreRedPacketCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/10/26.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

public typealias IngreJumpClosure = (String -> Void)

class IngreRedPacketCell: UITableViewCell {
    //点击事件
    var jumpClosure: IngreJumpClosure?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    //数据
    var listModel: IngreRecommendWidgetList? {
        didSet {
            showData()
        }
    }
    
    //显示数据
    func showData() {
        if listModel?.widget_data.count > 0 {
            //容器视图
            let containerView = UIView.createView()
            scrollView.addSubview(containerView)
            
            containerView.snp_makeConstraints(closure: { [unowned self] (make) in
                make.edges.equalTo(self.scrollView)
                make.height.equalTo(self.scrollView)
                
            })
            //上一次的视图
            var lastView: UIView? = nil
            
            let cnt = listModel?.widget_data.count
            
            
            for i in 0..<cnt! {
                let data = listModel?.widget_data[i]
                if data?.type == "image" {
                    //创建图片
                    let url = NSURL(string: (data?.content)!)
                    
                    let tmpImageView = UIImageView()
                    tmpImageView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                    containerView.addSubview(tmpImageView)
                    //约束
                     tmpImageView.snp_makeConstraints(closure: { (make) in
                            make.top.bottom.equalTo(containerView)
                            make.width.equalTo(210)
                        if i == 0 {
                            make.left.equalTo(containerView)
                        } else {
                            make.left.equalTo((lastView?.snp_right)!)
                        }
                        
                        })
                    lastView = tmpImageView
                }
            }
                //修改容器视图的宽度
            containerView.snp_makeConstraints(closure: { (make) in
                    make.right.equalTo(lastView!)
                    
                    
        })
           
    }
        
        
    }
    
    //创建cell的方法
    class func createRedPacketCellFor(tableView: UITableView, atIndexPath indexPath: NSIndexPath, listModel: IngreRecommendWidgetList) -> IngreRedPacketCell {
        let cellId = "ingreRedPacketCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? IngreRedPacketCell
        if nil == cell {
            cell = NSBundle.mainBundle().loadNibNamed("IngreRedPacketCell", owner: nil, options: nil).last as? IngreRedPacketCell
            
        }
        //数据
        cell?.listModel = listModel
        return cell!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
