//
//  DetailViewController.swift
//  Test_Protocol&Delegate
//
//  Created by forp on 16/4/7.
//  Copyright © 2016年 forp. All rights reserved.
//

import Foundation
import UIKit

import ObjectiveC

//定义协议改变Label内容
@objc protocol ChangeTextDelegate: NSObjectProtocol {
    //回调方法
    optional func changeText(controller:AnyObject,string:String)
}

protocol OptionalChangeTextDelegate: NSObjectProtocol {
    //回调方法
    func optionalChangeText(controller:AnyObject,string:String)
}
extension OptionalChangeTextDelegate {
    func optionalChangeText(controller:AnyObject,string:String) {
        print("Implemented in extension")
    }
}

class DetailViewController: UIViewController, UITextViewDelegate {
    
    // MARK:-- public properties
    var passedTag:Int?
    var info:AnyObject?
    
    
    // MARK:-- private
    @IBOutlet  weak var textViewDetail: UITextView!
    
    // MARK:-- global variables
    var temp = 0
    var delegate:ChangeTextDelegate?
    
    // MARK:-- override
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.loadDefaultData()
        self.loadDefaultSetting()
        self.loadDefaultView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- - Custom Functions
    // MARK:-- loadDefault
    func loadDefaultData() {
        //
    }
    func loadDefaultSetting() {
        //
        self.title = "DetailViewController"
        self.view.backgroundColor = UIColor.greenColor()
        self.view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.backgroundViewClicked)))
        
        if ((info?.isKindOfClass(NSString)) != nil) {
            self.textViewDetail.text = info as! String
        }
    }
    func loadDefaultView() {
        //
        let rect = CGRect(x:0,y:0,width:150,height:50)
        let myButton = UIButton(frame:rect)
        myButton.center = self.view.center
        myButton.setTitle("改变标题内容",forState:.Normal)
        myButton.addTarget(self,action:#selector(self.btnClicked),forControlEvents:.TouchUpInside)
        self.view.addSubview(myButton)
    }
    
    // MARK:-- actions
    func btnClicked(){
        temp += 1
        print("我被点击了！")
        
        //let strObtained = info as! String
        let strObtained = textViewDetail.text
        var mStrObtained = textViewDetail.text
        
        var range = strObtained.rangeOfString("(--")
        if range != nil {
            
            let rangeRemove = (range?.startIndex)!..<(strObtained.endIndex)
            
            range = (range?.endIndex)!..<(strObtained.endIndex.predecessor())
            let count = strObtained.substringWithRange(range!)
            temp = Int(count)! + 1
            
            mStrObtained.removeRange(rangeRemove)
        }
        
        if((delegate) != nil){
            delegate?.changeText!(self,string:"\(mStrObtained)(--"+String(temp)+")")
        }
        
    }
    
    func backgroundViewClicked(){
        if textViewDetail.canResignFirstResponder() {
            textViewDetail.resignFirstResponder()
        }
    }
    
    // MARK:- - Delegate
    // MARK:-- UITextViewDelegate
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        //
        print("ok")
        return true
    }
    
    
}


