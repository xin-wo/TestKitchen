//
//  FoodCourseComment.swift
//  TestKitchen
//
//  Created by qianfeng on 16/11/4.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit
import SwiftyJSON

class FoodCourseComment: NSObject {
    var code: String?
    var data: FoodCourseCommentData?
    var msg: String?
    var timestamp: NSNumber?
    var version: String?
    
    class func parseData(data: NSData) -> FoodCourseComment {
        let json = JSON(data: data)
        let model = FoodCourseComment()
        model.data = FoodCourseCommentData.parse(json["data"])
        model.code = json["code"].string
        model.msg = json["msg"].string
        model.timestamp = json["timestamp"].number
        model.version = json["version"].string
        
        return model
        
    }
    
  
    
}

class FoodCourseCommentData: NSObject {
    var count: String?
    var data: [FoodCourseCommentDetail]?
    var page: String?
    var size: String?
    var total: String?
    
    class func parse(json: JSON) -> FoodCourseCommentData {
        let model = FoodCourseCommentData()
        model.count = json["count"].string
        
        var array = [FoodCourseCommentDetail]()
        for (_, subjson) in json["data"] {
            let detail = FoodCourseCommentDetail.parse(subjson)
            array.append(detail)
            
        }
        
        model.data = array
        model.page = json["page"].string
        model.size = json["size"].string
        model.total = json["total"].string
        
        return model
    }
    
    
}

class FoodCourseCommentDetail: NSObject {
    var content: String?
    var create_time: String?
    var head_img: String?
    var id: String?
    var istalnet: NSNumber?
    var nick: String?
    var parent_id: String?
//    var parents: [FoodCourseCommentDetail]?
    var relate_id: String?
    var type: String?
    var user_id: String?
    
    class func parse(json: JSON) -> FoodCourseCommentDetail {
        let model = FoodCourseCommentDetail()
        model.content = json["content"].string
        model.create_time = json["create_time"].string
        model.head_img = json["head_img"].string
        model.id = json["id"].string
        model.istalnet = json["istalnet"].number
        model.nick = json["nick"].string
        model.parent_id = json["parent_id"].string
        
//        var array = [FoodCourseCommentDetail]()
//        for (_, subjson) in json["parents"] {
//            let pModel = FoodCourseCommentDetail.parse(subjson)
//            array.append(pModel)
//        }
//        
//        model.parents = array
        model.type = json["type"].string
        model.relate_id = json["relate_id"].string
        model.user_id = json["user_id"].string
       
        
        return model
        
    }
    
    
    
    
    
    
    
    
}



