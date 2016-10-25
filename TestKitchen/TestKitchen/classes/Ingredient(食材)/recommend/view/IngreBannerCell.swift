//
//  IngreBannerCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/10/25.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit


class IngreBannerCell: UITableViewCell {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageCtrl: UIPageControl!
    
    var bannerArray: Array<IngreRecommondBannerModel>! {
        didSet {
            // 显示数据
            showData()
        }
    }
    
    
    //显示数据
    private func showData() {
        //遍历添加图片
        let cnt = bannerArray.count
        
        if bannerArray.count > 0 {
            //滚动视图加约束
            //创建一个容器视图，作为滚动视图的子视图
            let containerView = UIView.createView()
            scrollView.addSubview(containerView)
            containerView.snp_makeConstraints(closure: { (make) in
                make.edges.equalTo(scrollView)
                //一定要设置高度
                make.height.equalTo(scrollView)
            })
            // 循环设置子视图的约束，子视图是添加到容器视图里面
            var lastView: UIView? = nil
            
            for i in 0..<cnt {
                let model = bannerArray[i]
                //创建图片
                let tmpImageView = UIImageView()
//                tmpImageView.kf_setImageWithURL(NSURL(string: model.banner_picture))
                tmpImageView.kf_setImageWithURL(NSURL(string: model.banner_picture), placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                containerView.addSubview(tmpImageView)
                //图片的约束
                tmpImageView.snp_makeConstraints(closure: { (make) in
                    make.top.bottom.equalTo(containerView)
                    make.width.equalTo(scrollView)
                    if lastView == nil {
                        make.left.equalTo(containerView)
                    } else {
                        make.left.equalTo((lastView?.snp_right)!)
                    }
                })
                
                lastView = tmpImageView
            }
            //修改container的宽度
            containerView.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(lastView!)
            })
            pageCtrl.numberOfPages = cnt
            scrollView.pagingEnabled = true
        }
    }
    
    
    // 创建cell的方法
    class func createBannerCellFor(tableView: UITableView, atIndexPath indexPath: NSIndexPath, bannerArray: Array<IngreRecommondBannerModel>?) -> IngreBannerCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("ingreBannerCellId", forIndexPath: indexPath) as! IngreBannerCell
//        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("IngreBannerCell", owner: nil, options: nil).last as! IngreBannerCell
//        }
        
        cell.bannerArray = bannerArray
        return cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    

    
}
//MARK: UIScrollView代理
extension IngreBannerCell: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x/scrollView.bounds.size.width
        pageCtrl.currentPage = Int(index)
    }
    
}







