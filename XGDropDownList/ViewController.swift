//
//  ViewController.swift
//  XGDropDownList
//
//  Created by user on 16/1/7.
//  Copyright © 2016年 郭晓广. All rights reserved.
//

import UIKit

class ViewController: UIViewController,XG_DropDownListProtocol,XG_customProtocol{

    var customList1 : customDropDownList!
    var customList2 : customDropDownList!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let width = self.view.frame.size.width
//        let height = self.view.frame.size.height
         customList1 = customDropDownList(frame: CGRectMake(0, 100, width/2-1, 40), tableArray:  ["全部颜色","黑色","灰色"])
        customList1.xg_delegate = self
        
//        customList.isOpen = true
//        customList1.backgroundColor=UIColor.blackColor()
        self.view.addSubview(customList1)
        customList2 = customDropDownList(frame: CGRectMake(width/2+1, 100, width/2-1, 40), tableArray:  ["全部水果","香蕉","橘子"])
        //        customList.isOpen = true
//        customList2.backgroundColor=UIColor.blackColor()
        self.view.addSubview(customList2)
        
       
        
        
        let customlist3 = XGDropDownList(frame:  CGRectMake(0, 300, width/2-1, 40), tableArray:["全部颜色","黑色","灰色"])
        customlist3.XG_DropDownListDelegate = self;
        self.view.addSubview(customlist3)
        
        
        let customList4 = XGDropDownList(frame: CGRectMake(width/2+1, 300, width/2-1, 40), tableArray: ["全部水果","香蕉","橘子"])
        self.view.addSubview(customList4)
        
        
        
        
        
        
    }
    func returnParams(button: UIButton) {
        
        print("\(button.currentTitle)");
        
    }
   
    func retunObjects(button: UIButton) {
        print("\(button.currentTitle)");
    }
    
    func btnAction(){
    
    
        customList1.isOpen = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

