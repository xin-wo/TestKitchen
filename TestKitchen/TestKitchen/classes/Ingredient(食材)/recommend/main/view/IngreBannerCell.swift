//
//  IngreBannerCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/10/25.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit


class IngreBannerCell: UITableViewCell {

    var jumpClosure: IngreJumpClosure?
    
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
        //滚动视图系统默认添加了一些子视图，删除子视图时要考虑一些会不会影响这些子视图
        //删除滚动视图之前的子视图
        for sub in scrollView.subviews {
            sub.removeFromSuperview()
        }
        
        //遍历添加图片
        if bannerArray != nil {
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
                    //添加点击事件
                    tmpImageView.userInteractionEnabled = true
                    tmpImageView.tag = 200 + i
                    let g = UITapGestureRecognizer(target: self, action: #selector(tapImage(_:)))
                    tmpImageView.addGestureRecognizer(g)
                    
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
    }
    
    func tapImage(g: UITapGestureRecognizer) {
        let index = (g.view?.tag)! - 200
        //获取点击的数据
        let banner = bannerArray[index]
        if jumpClosure != nil && banner.banner_link != nil {
            jumpClosure!(banner.banner_link)
        }
        
        
        
    }
    
    
    // 创建cell的方法
    class func createBannerCellFor(tableView: UITableView, atIndexPath indexPath: NSIndexPath, bannerArray: Array<IngreRecommondBannerModel>?) -> IngreBannerCell {
        //重用标志
        let cellId = "ingreBannerCellId"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? IngreBannerCell
        if nil == cell {
            //IngreBannerCell.xib
            cell = NSBundle.mainBundle().loadNibNamed("IngreBannerCell", owner: nil, options: nil).last as? IngreBannerCell
        }
        
        //显示数据
        cell?.bannerArray = bannerArray
        
        return cell!
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







