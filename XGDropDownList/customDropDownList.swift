//
//  customDropDownList.swift
//  XGDropDownList
//
//  Created by user on 16/1/7.
//  Copyright © 2016年 郭晓广. All rights reserved.
//

import UIKit

protocol XG_customProtocol
{
    func retunObjects(button:UIButton)
}


class customDropDownList: UIView,UITableViewDelegate,UITableViewDataSource {

    var xg_delegate: XG_DropDownListProtocol?
    var tv : UITableView!
    var tableArray : NSArray!
    var textButton : UIButton!
    var flag : NSString!
    var oldFrame : CGRect!
    var isOpen : Bool{
        /*!
        *   @brief didSet 在前面的属性 确实被设定后作出的 类似oc中 重写setValue
        *
        *   @since <#version number#>
        */
        didSet{
            
            print("did set")
            if self.isOpen
            {
                var frame = tv.frame
                frame.size.height = 0
                tv.frame = frame
                self.isOpen = false
                self.showList = false
                self.frame = oldFrame
                textButton.frame = CGRectMake(0, 0, self.frame.size.width,self.frame.size.height)
            }else
            {
                var frame = tv.frame
                frame.size.height = 0
                tv.frame = frame
                self.isOpen = false
                self.showList = false
                self.frame = oldFrame
                 textButton.frame =  CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
            }
            
        }
    }
    
    //外面需要定义的属性
    //以下为全局变量
    var showList : Bool
    var tabHeight : CGFloat!
    var frameHeight : CGFloat!
    var olderWidth : CGFloat!
    

     init(var frame: CGRect, tableArray:NSArray) {
       
        self.isOpen = false
        self.showList = false
        self.tableArray = tableArray
        super.init(frame:frame)
        
        frameHeight = frame.size.height
        tabHeight = frameHeight
        frame.size.height = 40.0
       
        oldFrame = self.frame
        showList = false
        
        let bgview = UIImageView()
        bgview.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        bgview.backgroundColor = UIColor.blackColor()
        bgview.alpha = 0.5
        self.addSubview(bgview)
        
        textButton = UIButton(type: .Custom)
        textButton.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        olderWidth = textButton.frame.size.width
        textButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        textButton.backgroundColor = UIColor.clearColor()
        textButton.titleLabel?.textAlignment = NSTextAlignment.Center
        textButton.setTitle(tableArray[0] as? String, forState: .Normal)
        textButton.addTarget(self, action: "dropdown", forControlEvents: .TouchUpInside)
     
//        textButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0)
        self.addSubview(textButton)
           self.xg_delegate?.returnParams(textButton)
        
        

        tv = UITableView(frame: CGRectMake(0, textButton.frame.size.height+textButton.frame.origin.y, self.frame.size.width, CGFloat(tableArray.count*40)), style: .Plain)
        tv.delegate = self
        tv.dataSource = self
        tv.separatorColor = UIColor(red: 57, green: 67, blue: 81, alpha: 1)
        tv.hidden = true
        tv.backgroundColor = UIColor.blueColor()
        self .addSubview(tv)
        

    }
    
    func NormalDropDownShow(isShow:Bool)->Bool
    {
        return isShow
    }
    
    func dropdown(){
    

        print("Dropdown")
        //判断是否展开列表
        if showList {
        
            
           self.NormalDropDownShow(false)
         
            tv.hidden = true
            showList = false
            var sf = self.frame
            sf.size.height = 40.0
            self.frame = sf
            var frame = tv.frame
            frame.size.height = 0
            tv.frame = frame
            
        }else
        {
        
            self.NormalDropDownShow(true)
            
            var sf = self.frame
            sf.size.height = CGFloat((tableArray.count+1)*40)
            
            //把dropdownList放到前面，防止下拉框被别的控件遮住
            self.superview?.bringSubviewToFront(self)
            tv.hidden = false;
            showList = true;//显示下拉框
            //        self.backgroundColor=[UIColor clearColor];
            var frame = tv.frame;
            //        frame.size.height =_tableArray.count*35;
            
            frame.size.height = tabHeight;
            frame.size.width = oldFrame.size.width
            tv.frame = frame
            UIView.beginAnimations("ResizeForKeyBoard", context: nil)
            UIView.setAnimationCurve(.Linear)
            self.frame = sf;
            tv.frame = CGRectMake(0, textButton.frame.origin.y+textButton.frame.size.height, self.frame.size.width,CGFloat(tableArray.count*40));

            UIView.commitAnimations()
        }
      self.xg_delegate!.returnParams(self.textButton)
    
    }
    //TableView.delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let str = "hallow"
        
        let cell = DropDownCell(style: .Default, reuseIdentifier: str)
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.selectionStyle = UITableViewCellSelectionStyle.Default
        //        cell.textLabel!.text=dataArr[indexPath.row] as? String
        cell.tag = indexPath.row
        cell.lable.text=tableArray[indexPath.row] as? String
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40;
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        textButton .setTitle(tableArray[indexPath.row] as? String, forState:.Normal)
        
        self.NormalDropDownShow(false)
        
        tv.hidden = true
        showList = false
        var sf = self.frame
        sf.size.height = 35.0
        self.frame = sf
        var frame = tv.frame
        frame.size.height = 0
        tv.frame = frame
        
          self.xg_delegate?.returnParams(self.textButton)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
