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
    //详情的数据
    private var detailData: FoodCourseDetail?
    
    //表格
    var tableView: UITableView!
     //创建表格
    func createTableView() {
        automaticallyAdjustsScrollViewInsets = false
        tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //下载详情的数据
        downloadDetailData()
        //创建表格
        createTableView()
        
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
                
                
            }
            
            
        } else if downloader.downloadType == .IngreFoodCourseComment {
            //评论
            
        }
    }
    
}
//MARK:UITableView的代理
    
extension FoodCourseController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            //详情
            return 3
        } else if section == 1 {
            //评论
            return 0
        }
        
        return 0
       
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return  0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}



