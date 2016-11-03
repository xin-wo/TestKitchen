//
//  IngreService.swift
//  TestKitchen
//
//  Created by qianfeng on 16/11/3.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class IngreService: NSObject {

    class func handleEvent(urlString: String, onViewController vc: UIViewController) {
        if urlString.hasPrefix("app://food_course_series") {
            //食材课程的分级显示
            let array = urlString.componentsSeparatedByString("#")
            
            if array.count > 1 {
                let courseId = array[1]
                FoodCourseService.handleFoodCourse(courseId, onViewController: vc)
                
            }
            
            
        }
        
        
    }
    
}
