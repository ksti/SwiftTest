//
//  UserInfo.swift
//  Test_Protocol&Delegate
//
//  Created by forp on 16/4/12.
//  Copyright © 2016年 forp. All rights reserved.
//

import UIKit

class UserInfo: NSObject {
    var name: String
    var password: String
    var phone: String?
    
    
    //构造方法
    init(name: String = "", phone: String? = "", password: String = ""){
        self.name = name
        self.phone = phone
        self.password = password
        super.init()
    }
    
    //从nsobject解析回来
    init(coder aDecoder:NSCoder!){
        self.name=aDecoder.decodeObjectForKey("Name") as! String
        self.phone=aDecoder.decodeObjectForKey("Phone") as? String
        self.password=aDecoder.decodeObjectForKey("Password") as! String
        
    }
    
    //编码成object
    func encodeWithCoder(aCoder:NSCoder!){
        aCoder.encodeObject(name,forKey:"Name")
        aCoder.encodeObject(phone,forKey:"Phone")
        aCoder.encodeObject(password,forKey:"Password")
    }
}
