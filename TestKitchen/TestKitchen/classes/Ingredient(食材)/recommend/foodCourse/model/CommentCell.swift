//
//  CommentCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/11/4.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    
    
    @IBOutlet weak var descLabel: UILabel!
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var imageIcon: UIImageView!
    
    //显示数据
    var model: FoodCourseCommentDetail? {
        didSet {
            if model != nil {
                //图片
                let url = NSURL(string: (model?.head_img)!)
                imageIcon.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                
                //名字
                userNameLabel.text = model?.nick
               
                //评论内容
                descLabel.text = model?.content
               
                //评论时间
                timeLabel.text = model?.create_time
            }
            
            
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageIcon.layer.cornerRadius = 30
        imageIcon.layer.masksToBounds = true
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
