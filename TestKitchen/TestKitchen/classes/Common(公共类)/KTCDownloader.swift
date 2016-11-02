//
//  KTCDownloader.swift
//  TestKitchen
//
//  Created by qianfeng on 16/10/24.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit
import Alamofire


protocol KTCDownloaderDelegate: NSObjectProtocol {
    //下载失败
    func downloader(downloader: KTCDownloader, didFailWithError error: NSError)
    
    
    //下载成功
    func downloader(downloader: KTCDownloader, didFinishWithData data: NSData?)
    
}

enum KTCDownLoadType: Int {
    case Normal = 0
    case IngreRecommend //首页食材的推荐
    case IngreMaterial  //首页食材的食材
    case IngreCategory  //首页食材的分类
}



class KTCDownloader: NSObject {
    
    //代理属性
    weak var delegate: KTCDownloaderDelegate?
    
    //下载的类型
    var downloadType: KTCDownLoadType = .Normal
    
    
    //POST请求数据
    func postWithUrl(urlString: String, params: Dictionary<String,AnyObject>) {
        
        var tmpDict = NSDictionary(dictionary: params) as! [String:AnyObject]
        //设置所有接口的公共参数
        tmpDict["token"] = ""
        tmpDict["user_id"] = ""
        tmpDict["version"] = "4.5"
        
        Alamofire.request(.POST, urlString, parameters: tmpDict, encoding: ParameterEncoding.URL, headers: nil).responseData { (response) in
            switch response.result {
                case .Failure(let error):
                //下载失败
                    self.delegate?.downloader(self, didFailWithError: error)
                
                case .Success:
                //下载成功
                    self.delegate?.downloader(self, didFinishWithData: response.data)
                
            }
        }
        
        
        
    }
    
    
}
