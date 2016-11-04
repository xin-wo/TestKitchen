//
//  FCCommentHeader.swift
//  TestKitchen
//
//  Created by qianfeng on 16/11/4.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class FCCommentHeader: UIView {

    @IBOutlet weak var titleLabel: UILabel!
   
    @IBAction func commentAction(sender: UIButton) {
        
    
    }
    
    func config(num: String) {
        titleLabel.text = "\(num)评论"
    }
    
    
}
