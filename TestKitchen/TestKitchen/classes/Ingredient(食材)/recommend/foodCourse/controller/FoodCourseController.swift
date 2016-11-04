//
//  FoodCourseController.swift
//  TestKitchen
//
//  Created by qianfeng on 16/11/3.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class FoodCourseController: BaseViewController {

    //id
    var courseId: String?
    //当前选择了第几集
    private var serialIndex: Int = 0
    
    
    //详情的数据
    private var detailData: FoodCourseDetail?
    
    //评论的数据
    private var comment: FoodCourseComment?
    
    //评论的分页
    private var curPage = 1
    
    //是否有更多
    private var hasMore = true
    
    //表格
    private var tableView: UITableView!
     //创建表格
    func createTableView() {
        automaticallyAdjustsScrollViewInsets = false
        tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp_makeConstraints { [weak self] (make) in
            make.edges.equalTo((self?.view)!).inset(UIEdgeInsets(top: 64, left: 0, bottom: 49, right: 0))
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //下载详情的数据
        downloadDetailData()
        //创建表格
        createTableView()
        //下载评论
        downloadComment()
    }
    
    //下载评论
    func downloadComment() {
        if courseId != nil {
            var params = [String:String]()
            params["methodName"] = "CommentList"
            params["page"] = "\(curPage)"
            params["relate_id"] = "\(courseId!)"
            params["size"] = "10"
            params["type"] = "2"
            let downloader = KTCDownloader()
            downloader.delegate = self
            downloader.downloadType = .IngreFoodCourseComment
            downloader.postWithUrl(kHostUrl, params: params)

        }

    }
    

    
    //下载详情的数据
    func downloadDetailData() {
        
        if courseId != nil {
            let params = ["methodName":"CourseSeriesView", "series_id":"\(courseId!)"]
            
            let downloader = KTCDownloader()
            downloader.delegate = self
            downloader.downloadType = .IngreFoodCourseDetail
            downloader.postWithUrl(kHostUrl, params: params)
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    

}
//MARK：KTCDownloader代理
extension FoodCourseController: KTCDownloaderDelegate  {
    func downloader(downloader: KTCDownloader, didFailWithError error: NSError) {
        print(error)
    }
    func downloader(downloader: KTCDownloader, didFinishWithData data: NSData?) {
        if downloader.downloadType == .IngreFoodCourseDetail {
            //详情
//            let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            print(str)
            if let tmpData = data {
                detailData = FoodCourseDetail.parseData(tmpData)
                //显示数据
                
                //刷新表格
                tableView.reloadData()
                
                
//                tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .None)
            }
            
            
        } else if downloader.downloadType == .IngreFoodCourseComment {
            //评论
            let tmpComment = FoodCourseComment.parseData(data!)
            if curPage == 1 {
                //第一页
                comment = tmpComment
            } else {
                //其他页
                let array = NSMutableArray(array: (comment?.data?.data)!)
                array.addObjectsFromArray((tmpComment.data?.data)!)
                comment?.data?.data = NSArray(array: array) as? [FoodCourseCommentDetail]
                
            }
         

            tableView.reloadSections(NSIndexSet(index: 1), withRowAnimation: .None)
//            tableView.reloadData()
           
            //判断是否有更多
            if comment?.data?.data?.count < NSString(string: (comment?.data?.total)!).integerValue {
                hasMore = true
            } else {
                hasMore = false
            }
            
            //加载更多
            
            addFooterView()
            
        }
    }
    //添加加载更多的视图
    func addFooterView() {
        let fView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 44))
        fView.backgroundColor = UIColor.grayColor()
        //显示文字
        let label = UILabel(frame: CGRectMake(20, 10, kScreenWidth - 20*2, 24))
        if hasMore {
            label.text = "下拉加载更多"
        } else {
            label.text = "没有更多了"
        }
        
        fView.addSubview(label)
        tableView.tableFooterView = fView
        
    }
    
    
}
//MARK:UITableView的代理
    
extension FoodCourseController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var num = 0
        
        
        if section == 0 {
            //详情
            if detailData != nil {
                num = 3
            }
            
        } else if section == 1 {
            //评论
            if comment?.data?.data?.count > 0 {
                num = (comment?.data?.data?.count)!
            }
          
        }
        
        return num
       
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var h: CGFloat = 0
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                //视频播放
                h = 160
                
            } else if indexPath.row == 1 {
                //文字
                let model = detailData?.data?.data![serialIndex]
                h = FCSubjectCell.heightForSubjectCell(model!)
                
            } else if indexPath.row == 2 {
                //集数
                h = FCSerialCell.heightForSerialCell(detailData!.data!.data!.count)
                
            }
            
            
        } else if indexPath.section == 1 {
            //评论
            h = 80
        }
        
        
        return  h
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                //视频
                let cellId = "videoCellId"
                var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? FCVideoCell
                if nil == cell {
                    cell = NSBundle.mainBundle().loadNibNamed("FCVideoCell", owner: nil, options: nil).last as? FCVideoCell
                }
                //显示数据
                let serialModel = detailData?.data?.data![serialIndex]
               
                cell?.cellModel = serialModel
                //播放的闭包
                cell?.playClosure = { [weak self] (urlString) in
                    IngreService.handleEvent(urlString, onViewController: self!)
                    
                }
                cell?.selectionStyle = .None
                
                
                return cell!
            } else if indexPath.row == 1 {
                //描述文字
                let cellId = "subjectCellId"
                var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? FCSubjectCell
                if cell == nil {
                    cell = NSBundle.mainBundle().loadNibNamed("FCSubjectCell", owner: nil, options: nil).last as? FCSubjectCell
                }
                //显示数据
                let model = detailData?.data?.data![serialIndex]
                cell?.cellModel = model
                cell?.selectionStyle = .None
                
                
                return cell!
                
                
            } else if indexPath.row == 2 {
                //集数
                let cellId = "serialCellId"
                var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? FCSerialCell
                if nil == cell {
                    cell = FCSerialCell(style: .Default, reuseIdentifier: cellId)
                    
                    
                }
                //显示数据
                cell?.serialNum = detailData?.data?.data?.count
                
                cell?.selectIndex = serialIndex
                
                cell?.clickClosure = { [weak self] (index) in
                    self!.serialIndex = index
                    //刷新表格
                    self?.tableView.reloadData()
                    
                }
                
                cell?.selectionStyle = .None
                return cell!
            }
            
            
            
        } else if indexPath.section == 1 {
            
            //评论
            let cellId = "commentCellId"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CommentCell
            if nil == cell {
                cell = NSBundle.mainBundle().loadNibNamed("CommentCell", owner: nil, options: nil).last as? CommentCell
            }
            
            //显示数据
            let model = comment?.data?.data![indexPath.row]
            cell?.model = model
            cell?.selectionStyle = .None
          
            return cell!
            
            
        }
       
        
        
        return UITableViewCell()
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.size.height - 10 {
            //可以加载更多
            if hasMore {
                //加载下一页
                curPage += 1
                downloadComment()
            }
            
            
        }
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            if comment?.data?.data?.count > 0 {
                return 60
            }
            
        }
        return 0
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let headerView = NSBundle.mainBundle().loadNibNamed("FCCommentHeader", owner: nil, options: nil).last as! FCCommentHeader
            //显示数据
            headerView.config((comment?.data?.total)!)
            return headerView
        }
        return nil
        
    }
}



