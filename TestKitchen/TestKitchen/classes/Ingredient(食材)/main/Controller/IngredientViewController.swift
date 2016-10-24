//
//  IngredientViewController.swift
//  TestKitchen
//
//  Created by qianfeng on 16/10/21.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class IngredientViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        downloadRecommendData()
        
    }
    //下载首页的推荐数据
    func downloadRecommendData() {
        let params = ["methodName":"SceneHome", "token":"", "user_id":"", "version":"4.5"]
        
        
        let downloader = KTCDownloader()
        downloader.delegate = self
        downloader.postWithUrl(kHostUrl, params: params)
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
//MARK: KTCDownloader代理方法
extension IngredientViewController: KTCDownloaderDelegate {
    func downloader(downloader: KTCDownloader, didFailWithError error: NSError) {
        print(error)
    }
    
    func downloader(downloader: KTCDownloader, didFinishWithData data: NSData?) {
        let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
        
        
    }
    
}



