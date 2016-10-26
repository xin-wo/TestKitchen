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
    
        automaticallyAdjustsScrollViewInsets = false
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
//        let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
//        print(str!)
        if let tmpData = data {
            let recommendModel = IngreRecommondModel.parseData(tmpData)
//            print("========")
            //2.显示UI
//            print(NSThread.currentThread())
            let recomendView = IngreRecomendView(frame: CGRectZero)
            recomendView.model = recommendModel
            view.addSubview(recomendView)

            //点击cell上的图片，跳转界面
            recomendView.jumpClosure = {
                jumpUrl in
                print(jumpUrl)
            }
            
            //约束
            recomendView.snp_makeConstraints(closure: { (make) in
                make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(64, 0, 49, 0))
            })
            
        }
        
        
        
        
    }
    
}



