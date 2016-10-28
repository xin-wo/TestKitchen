//
//  IngreSceneListCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/10/28.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class IngreSceneListCell: UITableViewCell {
    //点击事件
    var jumpClosure: IngreJumpClosure?
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var listModel: IngreRecommendWidgetList? {
        didSet {
            configLabel((listModel?.title)!)
        }
    }
    
    
    func configLabel(text: String) {
        titleLabel.text = text
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //点击手势
        let g = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        addGestureRecognizer(g)
        
    }

    class func createSceneListCellFor(tableView: UITableView, atIndexPath indexPath: NSIndexPath, listModel: IngreRecommendWidgetList?) -> IngreSceneListCell {
        let cellId = "ingreSceneListCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? IngreSceneListCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("IngreSceneListCell", owner: nil, options: nil).last as? IngreSceneListCell
        }
        
        cell?.listModel = listModel
        return cell!
    }
    
    
    func tapAction() {
        if jumpClosure != nil && listModel?.title_link != nil  {
            jumpClosure!((listModel?.title_link)!)
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
