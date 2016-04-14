//
//  UserDataModel.swift
//  Test_Protocol&Delegate
//
//  Created by forp on 16/4/12.
//  Copyright © 2016年 forp. All rights reserved.
//

import UIKit

let fileName_userList = "userList.plist"


class UserDataModel: NSObject {
    
    //var userList = [UserInfo]()
    //var userList = [UserInfo()]
    var userList = Dictionary<String, UserInfo>()
    
    
    
    override init(){
        super.init()
        print("沙盒文件夹路径：\(documentsDirectory())")
        print("数据文件路径：\(dataFilePath(fileName_userList))")
    }
    
    //保存数据
    func saveData() {
        let data = NSMutableData()
        //申明一个归档处理对象
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        //将lists以对应Checklist关键字进行编码
        archiver.encodeObject(userList, forKey: "userList")
        //编码结束
        archiver.finishEncoding()
        //数据写入
        data.writeToFile(dataFilePath(fileName_userList), atomically: true)
    }
    
    //读取数据
    func loadData() {
        //获取本地数据文件地址
        let path = self.dataFilePath(fileName_userList)
        //声明文件管理器
        let defaultManager = NSFileManager()
        //通过文件地址判断数据文件是否存在
        if defaultManager.fileExistsAtPath(path) {
            //读取文件数据
            let data = NSData(contentsOfFile: path)
            //解码器
            let unarchiver = NSKeyedUnarchiver(forReadingWithData: data!)
            //通过归档时设置的关键字Checklist还原lists
            //userList = unarchiver.decodeObjectForKey("userList") as! Array
            userList = unarchiver.decodeObjectForKey("userList") as! Dictionary
            //结束解码
            unarchiver.finishDecoding()
        }
    }
    
    //获取数据文件地址
    func dataFilePath(fileName: String) -> String{
        return documentsDirectory().stringByAppendingString(fileName)
    }
    
}

