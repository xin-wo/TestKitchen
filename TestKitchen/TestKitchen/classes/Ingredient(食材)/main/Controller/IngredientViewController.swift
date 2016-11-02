//
//  IngredientViewController.swift
//  TestKitchen
//
//  Created by qianfeng on 16/10/21.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class IngredientViewController: BaseViewController {
    
    
    //滚动视图
    private var scrollView: UIScrollView?
    
    //推荐视图
    private var recommendView = IngreRecomendView()
    
    //食材视图
    private var materialView: IngreMaterialView?
    
    //分类视图
    private var categoryView: IngreMaterialView?
    
    //导航上面的选择控件
    private var segCtrl: KTCSegCtrl?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //滚动视图或者其子视图放在导航下面，会自动加一个上面的间距,我们要取消这个间距
        automaticallyAdjustsScrollViewInsets = false
        
        //导航
        createNav()
        
        //创建首页视图
        createHomePage()
        
        //下载首页的推荐数据
        downloadRecommendData()
        
        //下载首页食材的数据
        downloadRecommendMaterial()
    }
    
    
    //创建首页视图
    func createHomePage() {
        
        scrollView = UIScrollView()
        scrollView!.pagingEnabled = true
        view.addSubview(scrollView!)
        
        scrollView?.delegate = self
        
        //约束
        scrollView!.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(64, 0, 49, 0))
        }
        
        //容器视图
        let containerView = UIView.createView()
        scrollView!.addSubview(containerView)
        containerView.snp_makeConstraints { (make) in
            make.edges.equalTo(scrollView!)
            make.height.equalTo(scrollView!)
        }
        
        //添加子视图
        //1.推荐视图
        recommendView = IngreRecomendView()
        containerView.addSubview(recommendView)
        recommendView.snp_makeConstraints(closure: { (make) in
            make.top.bottom.left.equalTo(containerView)
            make.width.equalTo(kScreenWidth)
        })
        
        //2.食材视图
        materialView = IngreMaterialView()
        materialView?.backgroundColor = UIColor.blueColor()
        containerView.addSubview(materialView!)
        
        materialView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(kScreenWidth)
            make.left.equalTo((recommendView.snp_right))
        })
        
        //3.分类视图
        categoryView = IngreMaterialView()
        categoryView?.backgroundColor = UIColor.redColor()
        containerView.addSubview(categoryView!)
        
        categoryView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(kScreenWidth)
            make.left.equalTo((materialView?.snp_right)!)
        })
        
        //修改容器视图的大小
        containerView.snp_makeConstraints { (make) in
            make.right.equalTo(categoryView!)
        }
        
    }
    
    
    //创建导航
    func createNav() {
        //扫一扫
        addNavBtn("saoyisao", target: self, action: #selector(scanAction), isleft: true)
        
        //搜索
        addNavBtn("search", target: self, action: #selector(searchAction), isleft: false)
        
        
        
        //选择控件
        let frame = CGRectMake(80, 0, kScreenWidth-80*2, 44)
        segCtrl = KTCSegCtrl(frame: frame, titleArray: ["推荐","食材","分类"])
        segCtrl!.delegate = self
        navigationItem.titleView = segCtrl
        
    }
    
    //扫一扫
    func scanAction() {
        print("扫一扫")
    }
    //搜索
    func searchAction() {
        print("搜索")
    }
    
    
    //下载首页的推荐数据
    func downloadRecommendData() {
        //methodName=SceneHome&token=&user_id=&version=4.5
        
        let params = ["methodName":"SceneHome", "token":"", "user_id":"", "version":"4.5"]
        
        let downloader = KTCDownloader()
        downloader.delegate = self
        downloader.downloadType = .IngreRecommend
        downloader.postWithUrl(kHostUrl, params: params)
        
    }
    
    func downloadRecommendMaterial() {
        
        let dict = ["methodName":"MaterialSubtype"]
        
        
        let downloader = KTCDownloader()
        downloader.delegate = self
        downloader.postWithUrl(kHostUrl, params: dict)
        downloader.downloadType = .IngreMaterial
        
        
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
    
    //下载失败
    func downloader(downloader: KTCDownloader, didFailWithError error: NSError) {
        print(error)
    }
    
    //下载成功
    func downloader(downloader: KTCDownloader, didFinishWithData data: NSData?) {
        if downloader.downloadType == .IngreRecommend {
            if let tmpData = data {
                //1.json解析
                let recommendModel = IngreRecommondModel.parseData(tmpData)
                
                //2.显示UI
                recommendView.model = recommendModel
                
                //3.点击食材的推荐页面的某一个部分，跳转到后面的界面
                recommendView.jumpClosure = {
                    jumpUrl in
                    print(jumpUrl)
                }
                
            }

        } else if downloader.downloadType == .IngreMaterial {
            if let tmpData = data {
                let materialModel = IngreMaterial.parseData(tmpData)
                materialView!.model = materialModel
//                IngreMaterialView.jumpClosure = {
//                    jumpUrl in
//                    print(jumpUrl)
//                }

            }
            
            
        } else if downloader.downloadType == .IngreCategory {
            
        }
        
        
        
        //        let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
        //        print(str!)
        
        
    }
    
}


//MARK: KTCSegCtrl代理
extension IngredientViewController: KTCSegCtrlDelegate {
    
    func segCtrl(segCtrl: KTCSegCtrl, didClickBtnAtIndex index: Int) {
        
        scrollView?.setContentOffset(CGPointMake(CGFloat(index)*kScreenWidth, 0), animated: true)
        
    }
    
}

//MARK: UIScrollView代理

extension IngredientViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x/scrollView.bounds.size.width
        segCtrl?.selectIndex = Int(index)
        
    }
    
}







