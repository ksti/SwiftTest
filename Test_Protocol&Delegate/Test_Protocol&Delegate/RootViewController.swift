//
//  RootViewController.swift
//  Test_Protocol&Delegate
//
//  Created by forp on 16/4/7.
//  Copyright © 2016年 forp. All rights reserved.
//

import Foundation
import UIKit

class RootViewController: UITableViewController, UITextViewDelegate, ChangeTextDelegate, OptionalChangeTextDelegate {
    
    var _dataItems : [AnyObject]?
    var _cellStyle : UITableViewCellStyle?
    
    /*
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    */
    
    override init(style aStyle: UITableViewStyle) {
        super.init(style: aStyle);
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder);
        
        _dataItems = [];
        self._cellStyle = UITableViewCellStyle.Default;
    }
    
    init(dataItems aDataItems:[AnyObject], cellStyle aCellStyle:UITableViewCellStyle)
    {
        
        super.init(style:UITableViewStyle.Plain);
        
        _dataItems = aDataItems;
        _cellStyle = aCellStyle;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // FIXME:-- 如果不在nib文件中链接代理，那么要手动设置代理，不过继承自UITableViewController似乎即使不设置代理也可以。。
        //self.tableView.dataSource = nil
        //self.tableView.delegate = nil
        
        // TODO:-- UIAlertView is deprecated. Use UIAlertController with a preferredStyle of UIAlertControllerStyleAlert instead
        let alert: UIAlertView = UIAlertView.init(title: "提示", message: "viewDidLoad", delegate: self, cancelButtonTitle: "确定")
        alert.show()
        
        
        // WARNING:-- warning
        /*
         if [ "${CONFIGURATION}" = "Debug" ]; then
         TAGS="TODO:|FIXME:|WARNING:"
         echo "searching ${SRCROOT} for ${TAGS}"
         find "${SRCROOT}" \( -name "*.swift" \) -print0 | xargs -0 egrep --with-filename --line-number --only-matching "($TAGS).*\$" | perl -p -e "s/($TAGS)/ warning: \$1/"
         fi
         */
        /*
         if [ "${CONFIGURATION}" = "Debug" ]; then
         TAGS="TODO:|FIXME:|WARNING:"
         ERRORTAG="ERROR/*_*/:"
         find "${SRCROOT}" \( -name "*.h" -or -name "*.m" -or -name "*.swift" \) -print0 | xargs -0 egrep --with-filename --line-number --only-matching "($TAGS).*\$|($ERRORTAG).*\$" | perl -p -e "s/($TAGS)/ warning: \$1/" | perl -p -e "s/($ERRORTAG)/ error: \$1/"
         fi
         */
        
        // WARNING:-- test a warning
        //self.tableView?.reloadData()
        
        self.loadDefaultData()
        self.loadDefaultSetting()
        self.loadDefaultView()
        
        print(NAV_BAR_HEIGHT(self))
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- UITableViewDataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return self._dataItems!.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //
        let rowId = "cellId"
        //var cell = tableView.dequeueReusableCellWithIdentifier(rowId) as UITableViewCell?
        var cell = tableView.dequeueReusableCellWithIdentifier(rowId)
        if (cell == nil)
        {
            cell = UITableViewCell(style: self._cellStyle!, reuseIdentifier: rowId)
        }
        
        let item = _dataItems?[indexPath.row]
        
        cell?.textLabel?.text = item as? String
        
        return cell!
    }
    
    // MARK:-- UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.detailPageWithIndexPath(indexPath)
    }
    
    // MARK:- - Custom Functions
    // MARK:-- loadDefault
    func loadDefaultData() {
        //
        for item in 1...3 {
            _dataItems?.append("item\(item)")
        }
    }
    func loadDefaultSetting() {
        //
    }
    func loadDefaultView() {
        //
        let rightBtn:UIBarButtonItem = UIBarButtonItem(title:"下一页",style:.Plain,target:self,action:#selector(RootViewController.nextPage))
        self.navigationItem.rightBarButtonItem = rightBtn
    }
    
    // MARK:-- actions
    func nextPage(){
        //let DetailVC = DetailViewController()
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("DetailViewController") as? DetailViewController
        detailVC?.delegate = self
        self.navigationController?.pushViewController(detailVC!,animated:true)
    }
    
    func detailPageWithIndexPath(indexPath: NSIndexPath){
        //let DetailVC = DetailViewController()
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("DetailViewController") as? DetailViewController
        detailVC?.delegate = self
        detailVC?.passedTag = indexPath.row
        detailVC?.info = _dataItems?[indexPath.row]
        self.navigationController?.pushViewController(detailVC!,animated:true)
    }
    
    // MARK:- - Delegate
    // MARK:-- ChangeTextDelegate
    func changeText(controller:AnyObject,string:String){
        if controller.isKindOfClass(DetailViewController) {
            let detailVC = controller as? DetailViewController
            //
            let strObtained = string
            var mStrObtained = string
            var range = strObtained.rangeOfString("(--")
            if range != nil {
                range = (range?.startIndex)!..<strObtained.endIndex
                
                mStrObtained.removeRange(range!)
                print(mStrObtained)
            }
            
            if (detailVC?.passedTag != nil) {
                self._dataItems?[detailVC!.passedTag!] = strObtained
            }
            
            self.tableView.reloadData()
            self.navigationController?.popViewControllerAnimated(true)
            
        }
    }
    
}
