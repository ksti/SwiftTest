//
//  RegisterViewController.swift
//  Test_Protocol&Delegate
//
//  Created by forp on 16/4/11.
//  Copyright © 2016年 forp. All rights reserved.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController,UITextFieldDelegate{
    
    var nameTF : UITextField!
    var passwordTF : UITextField!
    var num : String!
    
    var userDataModel = UserDataModel()
    
    var delegate : RegisterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "注册"
        
        let leftItem : UIBarButtonItem? = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(RegisterViewController.backClick))
        self.navigationItem.leftBarButtonItem = leftItem
        
        
        let numLbl : UILabel = UILabel()
        numLbl.frame = CGRectMake(10, 100, SCREEN_WIDTH-20, 40)
        numLbl.text = self.num
        numLbl.backgroundColor = UIColor.lightGrayColor()
        numLbl.textAlignment = NSTextAlignment.Center
        self.view.addSubview(numLbl)
        
        
        
        nameTF = UITextField(frame: CGRectMake(10, 150, SCREEN_WIDTH-20, 35))
        nameTF.placeholder = "输入姓名"
        nameTF.textAlignment = NSTextAlignment.Center
        nameTF.borderStyle = UITextBorderStyle.Line
        nameTF.clearButtonMode = UITextFieldViewMode.WhileEditing
        nameTF.delegate = self
        self.view.addSubview(nameTF)
        
        
        
        passwordTF = UITextField(frame: CGRectMake(10, 200, SCREEN_WIDTH-20, 35))
        passwordTF.placeholder = "输入密码"
        passwordTF.textAlignment = NSTextAlignment.Center
        passwordTF.borderStyle = UITextBorderStyle.Line
        passwordTF.clearButtonMode = UITextFieldViewMode.WhileEditing
        passwordTF.delegate = self
        self.view.addSubview(passwordTF)
        
        
        let submitBtn : UIButton = UIButton(frame: CGRectMake(10, 250, SCREEN_WIDTH-20, 40))
        submitBtn.backgroundColor = UIColor.lightGrayColor()
        submitBtn.setTitle("确定", forState: UIControlState.Normal)
        submitBtn.addTarget(self, action: #selector(RegisterViewController.submitClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(submitBtn)
    }
    
    func backClick(sender : UIButton)
    {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
            print("我要取消了，你知道吗？");
        })
    }
    
    func submitClick(sender : UIButton)
    {
        goBack()
    }
    
    func goBack(){
        
        if (nameTF.text!.isEmpty) || (passwordTF.text!.isEmpty) {
            
            //let alert : UIAlertView = UIAlertView(title: "不能为空", message: "填写你的名字", delegate: nil, cancelButtonTitle: "知道了")
            //alert.show()
            let alert : UIAlertController = UIAlertController(title: "不能为空", message: "填写你的名字和密码", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "好的", style: UIAlertActionStyle.Default, handler: nil)
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: {
                //
            })
            
            nameTF.becomeFirstResponder()
            
        } else {
            //存储：持久化数据
            userDataModel.userList.updateValue(UserInfo(name: self.nameTF!.text!, phone: nil, password: passwordTF.text!), forKey: self.num)
            userDataModel.saveData()
            
            self.delegate?.registerName(self.nameTF.text)
            
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                
                print("我要确定了，你知道吗？");
            })
        }
        
    }
    
    
    
    //MARK: TFDELEGATE
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        goBack()
        
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

