//
//  IngreMaterialCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/11/2.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class IngreMaterialCell: UITableViewCell {

    var cellModel: IngreMaterialType? {
        didSet {
            if cellModel != nil {
                showData()
            }
            
        }
    }
    //标题的高度
    private var titleH: CGFloat = 20
    //间距
    private var margin: CGFloat = 10
    //按钮的高度
    private var btnH: CGFloat = 44
    //按钮的列数
    private var column = 5
    
    //按钮的宽度
    private var btnW: CGFloat {
        return (kScreenWidth-CGFloat(column+1)*margin)/CGFloat(column)
    }
    
    
    func showData() {
        //类型标题
        let titleLabel = UILabel.createLabel(cellModel!.text, textAlignment: .Left, font: UIFont.systemFontOfSize(17))
        
        contentView.addSubview(titleLabel)
        //约束
        titleLabel.snp_makeConstraints { [weak self] (make) in
            make.left.top.equalTo(self!.margin)
            make.right.equalTo(-self!.margin)
            make.height.equalTo(self!.titleH)
        }
        
        
        //左边的图片
        let typeImageView = UIImageView()
        let url = NSURL(string: (cellModel?.image)!)
        typeImageView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        contentView.addSubview(typeImageView)
        
        //约束
        typeImageView.snp_makeConstraints { (make) in
            make.left.equalTo(margin)
            make.top.equalTo(margin*2+titleH)
            make.width.equalTo(btnW*2+margin)
            make.height.equalTo(btnH*2+margin)
        }
        
        //子类型按钮
        let cnt = cellModel?.data?.count
        if cnt > 0 {
            for i in 0..<cnt! {
                //3.1 显示文字
                let model = cellModel?.data![i]
                let btn = IngreMaterialBtn()
                btn.model = model
                btn.backgroundColor = UIColor.grayColor()
                contentView.addSubview(btn)
                
                //3.2 约束
                //前两行按钮
                if i < 6 {
                    let col = i%(column-2)
                    let row = i/(column-2)
                    btn.snp_makeConstraints(closure: { (make) in
                        let x = btnW*2+margin*3+(btnW+margin)*CGFloat(col)
                        make.left.equalTo(x)
                        let top = titleH+margin*2+(btnH+margin)*CGFloat(row)
                        make.top.equalTo(top)
                        make.width.equalTo(btnW)
                        make.height.equalTo(btnH)
                    })
                    
                    //后几行按钮
                } else {
                    let col = (i-6)%column
                    let row = (i-6)/column
                    btn.snp_makeConstraints(closure: { (make) in
                        let x = margin+(margin+btnW)*CGFloat(col)
                        make.left.equalTo(x)
                        let topMargin = margin+(btnH+margin)*CGFloat(row)
                        make.top.equalTo(typeImageView.snp_bottom).offset(topMargin)
                        make.width.equalTo(btnW)
                        make.height.equalTo(btnH)
                    })
                }
            }
        }
        
        
        
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


class IngreMaterialBtn: UIControl {
    
    private var titleLabel: UILabel?
    //显示数据
    var model: IngreMaterialSubtype? {
        //显示文字
        didSet {
            titleLabel?.text = model?.text
        }
    }
    
    
    
    
    init() {
        super.init(frame: CGRectZero)
        titleLabel = UILabel.createLabel(nil, textAlignment: .Center, font: UIFont.systemFontOfSize(17))
        addSubview(titleLabel!)
        //约束
        titleLabel?.snp_makeConstraints(closure: { (make) in
            make.edges.equalTo(self)
        })
        
        //背景颜色
        backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}






