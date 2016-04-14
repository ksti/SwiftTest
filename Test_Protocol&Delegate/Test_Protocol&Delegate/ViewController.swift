//
//  ViewController.swift
//  Test_Protocol&Delegate
//
//  Created by forp on 16/4/7.
//  Copyright © 2016年 forp. All rights reserved.
//

import UIKit

//

class ViewController: UIViewController {
    
    let rootVC = RootViewController(dataItems: ["Item1","Item2"],cellStyle: UITableViewCellStyle.Default)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //let ctrl3 = RootViewController(dataItems: ["Item1","Item2"],cellStyle: UITableViewCellStyle.Default)
        
        rootVC.view.frame = self.view.bounds
        self.view.addSubview(rootVC.view)
        
        if rootVC.tableView != nil {
            
            rootVC.tableView.reloadData()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

