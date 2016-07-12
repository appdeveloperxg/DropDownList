//
//  DropDownCell.swift
//  XGDropDownList
//
//  Created by user on 16/1/7.
//  Copyright © 2016年 郭晓广. All rights reserved.
//

import UIKit

class DropDownCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var lable : UILabel!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        let view = UIView()
        view.frame = super.frame
        view.backgroundColor = UIColor.blackColor()
        view.alpha = 0.3
        self.addSubview(view)
        
        lable = UILabel()
        lable.frame = CGRectMake(10, 10, 100, 20)
        lable.backgroundColor = UIColor.clearColor()
        self.addSubview(lable)
        
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
