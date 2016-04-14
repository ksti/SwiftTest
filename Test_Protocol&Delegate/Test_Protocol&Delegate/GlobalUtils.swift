//
//  GlobalUtils.swift
//  Test_Protocol&Delegate
//
//  Created by forp on 16/4/12.
//  Copyright © 2016年 forp. All rights reserved.
//

import Foundation
import UIKit

let NAV_BAR_HEIGHT:(UIViewController) -> (CGFloat?) = {(a:UIViewController) -> (CGFloat?) in a.navigationController?.navigationBar.bounds.size.height}

//获取沙盒文件夹路径
func documentsDirectory() -> String {
    let paths = NSSearchPathForDirectoriesInDomains(
        NSSearchPathDirectory.DocumentationDirectory,NSSearchPathDomainMask.UserDomainMask,true)
    let documentsDirectory:String = paths.first! as String
    return documentsDirectory
}

func cachesDirectory() -> String {
    let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true);
    let documentsDirectory:String = paths.first! as String
    return documentsDirectory
}

func temporaryDirectory() -> String {
    return NSTemporaryDirectory()
}
