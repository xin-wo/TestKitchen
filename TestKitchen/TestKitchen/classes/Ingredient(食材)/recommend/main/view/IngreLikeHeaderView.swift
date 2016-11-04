//
//  IngreLikeHeaderView.swift
//  TestKitchen
//
//  Created by qianfeng on 16/10/26.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class IngreLikeHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //设置背景颜色
        backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
        
        //文本输入框
        let textField = UITextField(frame: CGRectMake(40, 4, bounds.size.width - 40*2, 28))
        
        textField.placeholder = "输入菜名或食材搜索"
        textField.borderStyle = .RoundedRect
        addSubview(textField)
        
        //设置左边的搜索图片
        let image = UIImage(named: "search1")
        
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        textField.leftView = imageView
        textField.leftViewMode = .Always
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
