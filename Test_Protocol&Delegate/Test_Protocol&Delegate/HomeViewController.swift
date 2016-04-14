//
//  HomeViewController.swift
//  Test_Protocol&Delegate
//
//  Created by forp on 16/4/11.
//  Copyright © 2016年 forp. All rights reserved.
//

import Foundation
import UIKit


// 不管谁定的协议，遵守协议的要实现协议方法（也就是说实现协议方法的就是代理），其他人只要知道你遵循了这个协议就可以交由你代(为)(处)理
protocol RegisterDelegate{
    func registerName(name : String?)
}

class HomeViewController: UIViewController,RegisterDelegate {
    
    var nameLbl : UILabel!
    var numTF : UITextField!
    
    var userDataModel = UserDataModel()
    
    
    // MARK:-- override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        #if FREE_VERSION
            // 实际功能
            print("FREE_VERSION")
        #else
            // 弹出购买提示，导航至商店等
            print("NOT FOR FREE")
        #endif
        
        self.view.backgroundColor = UIColor.whiteColor()
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "homeBackground")!)
        
        self.loadDefaultData()
        self.loadDefaultSetting()
        self.loadDefaultView()
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK:-- load default
    // MARK:- - Custom Functions
    // MARK:-- loadDefault
    func loadDefaultData() {
        //
    }
    func loadDefaultSetting() {
        //
    }
    func loadDefaultView() {
        
        #if FREE_VERSION
            // 实际功能
            print("FREE_VERSION")
        #else
            // 弹出购买提示，导航至商店等
            print("NOT FOR FREE")
        #endif
        
        #if DEBUG
            print("DEBUG")
        #else
            print("DEBUG")
        #endif
        
        //
        let imgViewBackground = UIImageView(image: UIImage(named: "homeBackground"))
        imgViewBackground.frame = self.view.bounds
        imgViewBackground.contentMode = .ScaleAspectFill
        self.view.addSubview(imgViewBackground)
        
        
        let titleItem : UINavigationItem = UINavigationItem(title: "首页")
        let NVC : UINavigationBar = UINavigationBar(frame: CGRectMake(0, 20, SCREEN_WIDTH, 44))
        NVC.setItems([titleItem], animated: true)
        self.view.addSubview(NVC)
        
        print(NAV_BAR_HEIGHT(self))
        
        
        
        numTF = UITextField(frame: CGRectMake(10, 100, SCREEN_WIDTH-20, 35))
        numTF.placeholder = "输入学号"
        numTF.borderStyle = UITextBorderStyle.Line
        numTF.textAlignment = NSTextAlignment.Center
        numTF.clearButtonMode = UITextFieldViewMode.WhileEditing
        self.view.addSubview(numTF)
        
        nameLbl = UILabel()
        nameLbl.frame = CGRectMake(10, 150, SCREEN_WIDTH-20, 40)
        nameLbl.text = ""
        nameLbl.backgroundColor = UIColor.lightGrayColor()
        nameLbl.textAlignment = NSTextAlignment.Center
        self.view.addSubview(nameLbl)
        
        
        
        let registerBtn : UIButton = UIButton()
        registerBtn.frame = CGRectMake(10, 200, SCREEN_WIDTH-20, 40)
        registerBtn.backgroundColor = UIColor.lightGrayColor()
        registerBtn.setTitle("注册", forState: UIControlState.Normal)
        registerBtn.addTarget(self, action: #selector(HomeViewController.registerClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(registerBtn)
        
        
        
        let loginBtn : UIButton = UIButton()
        loginBtn.frame = CGRectMake(10, 250, SCREEN_WIDTH-20, 40)
        loginBtn.backgroundColor = UIColor.lightGrayColor()
        loginBtn.setTitle("登录", forState: UIControlState.Normal)
        loginBtn.addTarget(self, action: #selector(HomeViewController.loginClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(loginBtn)
    }
    
    // MARK:- - Custom Functions
    // MARK:-- utils
    //获取数据文件地址
    func dataFilePath(fileName: String) -> String{
        return documentsDirectory().stringByAppendingString(fileName)
    }
    
    // MARK:-- actions
    func registerClick(sender: UIButton) {
        //
        self.goRegister()
    }
    
    func goRegister(){
        
        if numTF.text!.isEmpty {
            
            //let alert : UIAlertView = UIAlertView(title: "不能为空", message: "填写你的学号", delegate: nil, cancelButtonTitle: "知道了")
            //alert.show()
            let alert : UIAlertController = UIAlertController(title: "不能为空", message: "填写你的学号", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "好的", style: UIAlertActionStyle.Default, handler: nil)
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: { 
                //
            })
            
            numTF.becomeFirstResponder()
            
        }else{
            
            let rootVC :RegisterViewController = RegisterViewController()
            rootVC.delegate = self;
            rootVC.num = self.numTF.text
            
            let NVC :UINavigationController = UINavigationController(rootViewController: rootVC)
            self.presentViewController(NVC, animated: true, completion: nil)
        }
        
    }
    
    
    
    func loginClick(sender: UIButton) {
        //
        self.goLogin()
    }
    
    func goLogin(){
        
        if numTF.text!.isEmpty {
            
            //let alert : UIAlertView = UIAlertView(title: "不能为空", message: "填写你的学号", delegate: nil, cancelButtonTitle: "知道了")
            //alert.show()
            let alert : UIAlertController = UIAlertController(title: "不能为空", message: "填写你的学号", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "好的", style: UIAlertActionStyle.Default, handler: nil)
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: {
                //
            })
            
            numTF.becomeFirstResponder()
            
        } else {
            let alert : UIAlertController = UIAlertController(title: "文本对话框", message: "登录和密码对话框示例", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addTextFieldWithConfigurationHandler {
                (textField: UITextField!) -> Void in
                textField.placeholder = "登录"
                textField.text = self.numTF.text
                NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeViewController.alertTextFieldDidChange(_:)), name: UITextFieldTextDidChangeNotification, object: textField)
            }
            alert.addTextFieldWithConfigurationHandler {
                (textField: UITextField!) -> Void in
                textField.placeholder = "密码"
                textField.secureTextEntry = true
            }
            let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: { (action: UIAlertAction) in
                NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: nil)
            })
            let okAction = UIAlertAction(title: "登录", style: UIAlertActionStyle.Default) {
                (action: UIAlertAction!) -> Void in
                
                NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: nil)
                
                let login = (alert.textFields?.first)! as UITextField
                let password = (alert.textFields?.last)! as UITextField
                
                self.userDataModel = UserDataModel()
                self.userDataModel.loadData()
                let userInfo = self.userDataModel.userList[login.text!]
                if userInfo?.password == password.text {
                    
                    let rootVC :RootViewController? = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("RootViewController") as? RootViewController
                    
                    let NVC :UINavigationController = UINavigationController(rootViewController: rootVC!)
                    self.presentViewController(NVC, animated: true, completion: nil)
                } else {
                    let alert : UIAlertController = UIAlertController(title: "提示框", message: "用户名或密码错误", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "知道了", style: UIAlertActionStyle.Cancel, handler: nil))
                    self.presentViewController(alert, animated: true, completion: {
                        //
                    })
                }
            }
            let setPasswordAction = UIAlertAction(title: "忘记密码", style: UIAlertActionStyle.Default) {
                (action: UIAlertAction!) -> Void in
                let login = (alert.textFields?.first)! as UITextField
                
                self.userDataModel = UserDataModel()
                self.userDataModel.loadData()
                let userInfo = self.userDataModel.userList[login.text!]
                if (userInfo != nil) {
                    
                    NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: nil)
                    
                    let alert : UIAlertController = UIAlertController(title: "文本对话框", message: "修改密码对话框示例", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addTextFieldWithConfigurationHandler {
                        (textField: UITextField!) -> Void in
                        textField.placeholder = "原密码"
                        textField.text = userInfo?.password //
                    }
                    alert.addTextFieldWithConfigurationHandler {
                        (textField: UITextField!) -> Void in
                        textField.placeholder = "新密码"
                        textField.secureTextEntry = true
                    }
                    alert.addTextFieldWithConfigurationHandler {
                        (textField: UITextField!) -> Void in
                        textField.placeholder = "确认新密码"
                        textField.secureTextEntry = true
                    }
                    let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: { (action: UIAlertAction) in
                        action.enabled = false
                        print("action:\(action)\naction.enabled:\(action.enabled)")
                    })
                    let okAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.Default) {
                        (action: UIAlertAction!) -> Void in
                        let newPassword = (alert.textFields?[1])! as UITextField
                        let newPassword2 = (alert.textFields?.last)! as UITextField
                        
                        //存储：持久化数据
                        userInfo?.password = newPassword2.text!
                        self.userDataModel.userList.updateValue(userInfo!, forKey: self.numTF.text!)
                        self.userDataModel.saveData()
                        
                        if newPassword.text == newPassword2.text {
                            self.dismissViewControllerAnimated(true, completion: {
                                //
                            })
                        } else {
                            let alert : UIAlertController = UIAlertController(title: "提示框", message: "两次密码不一致", preferredStyle: UIAlertControllerStyle.Alert)
                            alert.addAction(UIAlertAction(title: "知道了", style: UIAlertActionStyle.Cancel, handler: nil))
                            self.presentViewController(alert, animated: true, completion: {
                                //
                            })
                        }
                    }
                    alert.addAction(cancelAction)
                    alert.addAction(okAction)
                    
                    self.presentViewController(alert, animated: true, completion: {
                        //
                    })
                } else {
                    let alert : UIAlertController = UIAlertController(title: "提示框", message: "用户不存在请先注册", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "知道了", style: UIAlertActionStyle.Cancel, handler: nil))
                    self.presentViewController(alert, animated: true, completion: {
                        //
                    })
                }
            }
            
            let login = alert.textFields!.first! as UITextField
            okAction.enabled =  login.text?.characters.count > 0
            setPasswordAction.enabled =  login.text?.characters.count > 0
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            alert.addAction(setPasswordAction)
            
            self.presentViewController(alert, animated: true, completion: {
                //
            })
        }
        
    }
    
    // MARK:- - delegate
    // MARK:-- RegisterDelegate
    func registerName(name: String?) {
        nameLbl.text = name
    }
    
    // MARK:-- UITextFieldTextDidChangeNotification
    func alertTextFieldDidChange(notification: NSNotification) {
        //(NSNotification *)notify
        let textField = notification.object as! UITextField
        
        print(textField.text)
        print(textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        print(textField.text?.characters.count)
        
        let alertController = self.presentedViewController as! UIAlertController?
        if (alertController != nil) {
            let login = alertController!.textFields!.first! as UITextField
            let okAction = alertController!.actions[1] as UIAlertAction
            okAction.enabled = login.text?.characters.count > 0
            let setPasswordAction = alertController!.actions.last! as UIAlertAction
            setPasswordAction.enabled = textField.text?.characters.count > 0
        }
    }
    
}
