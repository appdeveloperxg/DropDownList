//
//  XGDropDownList.swift
//  XGDropDownList
//
//  Created by user on 16/1/8.
//  Copyright © 2016年 郭晓广. All rights reserved.
//

import UIKit

protocol XG_DropDownListProtocol{
    //协议中得方法不能有结构体
    func returnParams(button: UIButton)
}

class XGDropDownList: UIView,UITableViewDelegate,UITableViewDataSource {
    
    //外面需要定义的属性
    //以下为全局变量
    var XG_DropDownListDelegate: XG_DropDownListProtocol?
    var showList : Bool
    var tabHeight : CGFloat!
    var frameHeight : CGFloat!
    var olderWidth : CGFloat!
    let HEIGHT = UIScreen.mainScreen().bounds.size.height
    let WIDTH  = UIScreen.mainScreen().bounds.size.width
    var bgview : UIImageView!
        var tv : UITableView!
        var tableArray : NSArray!
        var textButton : UIButton!
        var flag : NSString!
        var oldFrame : CGRect!
        var isOpen : Bool{
            
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
    
        //初始化
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
            
            bgview = UIImageView()
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
            self.XG_DropDownListDelegate?.returnParams(self.textButton);
            //        textButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0)
                       self.addSubview(textButton)
            
            
            
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
            self.XG_DropDownListDelegate?.returnParams(self.textButton);

            print("Dropdown")
            if showList {
                
                
                self.NormalDropDownShow(false)
                
                tv.hidden = true
                showList = false
                var sf = self.frame
                sf.size.height = 40.0
                self.frame = oldFrame
                if(oldFrame.origin.x>0)
                {
                    self.textButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
                    self.bgview.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
                }
                
                var frame = tv.frame
                frame.size.height = 0
                tv.frame = frame
                
            }else
            {
                
                self.NormalDropDownShow(true)
                var sf = self.frame
                sf.size.height = CGFloat((tableArray.count+1)*40)
                sf.size.width = WIDTH
                sf.origin.x = 0
                sf.origin.y = oldFrame.origin.y
                //把dropdownList放到前面，防止下拉框被别的控件遮住
                self.superview?.bringSubviewToFront(self)
                tv.hidden = false;
                showList = true;//显示下拉框
                

                if oldFrame.origin.x>0{
                    self.textButton.frame = CGRectMake(oldFrame.origin.x, 0, oldFrame.size.width, oldFrame.height)
                    self.bgview.frame = CGRectMake(oldFrame.origin.x, 0, oldFrame.size.width,  oldFrame.height)
                }
                 self.frame = sf
                var frame = tv.frame
                frame.size.height = 0
                frame.size.width = WIDTH
                tv.frame = frame
                
                UIView.beginAnimations("ResizeForKeyBoard", context: nil)
                UIView.setAnimationCurve(.Linear)
               
                tv.frame = CGRectMake(0, textButton.frame.origin.y+textButton.frame.size.height, self.frame.size.width,CGFloat(tableArray.count*40));
                
                UIView.commitAnimations()
            }
            
            
        }
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
            self.frame = oldFrame
            if(oldFrame.origin.x>0)
            {
                self.textButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
                self.bgview.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
                
            
            }
            var frame = tv.frame
            frame.size.height = 0
            tv.frame = frame
            self.XG_DropDownListDelegate?.returnParams(self.textButton);
        }
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
   

}
