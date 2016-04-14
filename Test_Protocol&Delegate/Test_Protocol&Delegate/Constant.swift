//
//  Constant.swift
//  Test_Protocol&Delegate
//
//  Created by forp on 16/4/12.
//  Copyright © 2016年 forp. All rights reserved.
//

import Foundation
import UIKit


#if os(OSX)
    typealias Color = NSColor
#elseif os(OSX)
    typealias Color = UIColor
#endif

let IS_IOS7 = (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 7.0
let IS_IOS8 = (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 8.0

let SCREEN_SIZE = UIScreen.mainScreen().bounds.size
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.height
let SCREEN_WIDTH = SCREEN_SIZE.width





