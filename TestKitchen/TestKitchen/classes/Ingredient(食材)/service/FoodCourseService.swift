//
//  FoodCourseService.swift
//  TestKitchen
//
//  Created by qianfeng on 16/11/3.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class FoodCourseService: NSObject {
    
    class func handleFoodCourse(courseId: String, onViewController vc: UIViewController) {
        //跳转到食材课程分页的界面
        let ctrl = FoodCourseController()
        ctrl.courseId = courseId
        ctrl.hidesBottomBarWhenPushed = true
        vc.navigationController?.pushViewController(ctrl, animated: true)
        
        
        
    }
    
    
    
    
    
}
