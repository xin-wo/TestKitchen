//
//  UIButton+Common.swift
//  TestKitchen
//
//  Created by qianfeng on 16/10/21.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    class func createButton(title: String?, bgImageName: String?, hightLightImageName: String?, selectImageName: String?, target: AnyObject?, action: Selector) -> UIButton {
        let btn = UIButton(type: .Custom)
        
        if let tmpTitle = title {
            btn.setTitle(tmpTitle, forState: .Normal)
            btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        }
        if bgImageName != nil {
            btn.setImage(UIImage(named: bgImageName!), forState: .Normal)
        }
        
        if let tmpHighLightImageName = hightLightImageName {
            btn.setImage(UIImage(named: tmpHighLightImageName), forState: .Highlighted)
        }
        if let tmpSelectImageName = selectImageName     {
            btn.setImage(UIImage(named: tmpSelectImageName), forState: .Selected)
        }
        
        if target != nil && action != nil {
            btn.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        }
        
        
        return btn
    }
    
}
