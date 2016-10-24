//
//  IngreRecommondModel.swift
//  TestKitchen
//
//  Created by qianfeng on 16/10/24.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit
import SwiftyJSON

class IngreRecommondModel: NSObject {
    var code: NSNumber!
    var data: IngreRecommondDataModel!
    var msg: NSNumber!
    var timestamp: NSNumber!
    var version: String!

    //解析
    class func parseData(data: NSData) -> IngreRecommondModel {
        let json = JSON(data: data)
        
        let model = IngreRecommondModel()
        model.code = json["code"].number
        model.data = IngreRecommondDataModel.parseModel(json["data"])
        model.msg = json["msg"].number
        model.timestamp = json["timestamp"].number
        model.version = json["version"].string
        return model
    }
}

class IngreRecommondDataModel: NSObject {
    var bannerArray: Array<IngreRecommondBannerModel>!
    var widgetList: Array<NSObject>!
    
    //解析
    class func parseModel(json: JSON) -> IngreRecommondDataModel {
        let model = IngreRecommondDataModel()
        //广告数据
        var tmpBannerArray = Array<IngreRecommondBannerModel>()
        for (_, subjson) in json["bannerArray"] {
            let bannerModel = IngreRecommondBannerModel.parseModel(subjson)
            
            tmpBannerArray.append(bannerModel)
            
        }
        model.bannerArray = tmpBannerArray
        //列表数据
        var tmpList = Array<NSObject>()
        
        for (_, subjson):(String, JSON) in json["widgetList"] {
            let wModel = NSObject()
            tmpList.append(wModel)
            
        }
        model.widgetList = tmpList
        
        return model
    }
    
    
}

class IngreRecommondBannerModel: NSObject {
    var banner_id: NSNumber!
    var banner_link: String!
    var banner_picture: String!
    var banner_title: String!
    var is_link: NSNumber!
    var refer_key: NSNumber!
    var type_id: NSNumber!
    
    //解析
    class func parseModel(json: JSON) -> IngreRecommondBannerModel {
        let model = IngreRecommondBannerModel()
        model.banner_id = json["banner_id"].number
        model.banner_link = json["banner_link"].string
        model.banner_title = json["banner_title"].string
        model.banner_picture = json["banner_picture"].string
        model.is_link = json["is_link"].number
        model.refer_key = json["refer_key"].number
        model.type_id = json["type_id"].number
        
        return model
    }
    
}





