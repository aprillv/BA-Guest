//
//  PrintModelTableViewController.swift
//  Contract
//
//  Created by April on 2/18/16.
//  Copyright © 2016 HapApp. All rights reserved.
//

import UIKit
protocol ToDoPrintDelegate
{
    func GoToPrint(modelNm: String)
}
class PrintModelTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate{
    // MARK: - Constanse
    
    
    var delegate : ToDoPrintDelegate?
    
    
    
    @IBAction func dismissSelf(sender: UITapGestureRecognizer) {
        //        print(sender)
        //        let point = sender.locationInView(view)
        //        if !CGRectContainsPoint(tableview.frame, point) {
        self.dismissViewControllerAnimated(true){}
        //        }
        
        
        
    }
    @IBOutlet var tableHeight: NSLayoutConstraint!
    
    @IBOutlet var tablex: NSLayoutConstraint!
    @IBOutlet var tabley: NSLayoutConstraint!
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        let point = touch.locationInView(view)
        return !CGRectContainsPoint(tableview.frame, point)
    }
    @IBOutlet var tableview: UITableView!{
        didSet{
            tableview.layer.cornerRadius = 8.0
        }
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.title = "Print"
        view.superview?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        //        view.superview?.bounds = CGRect(x: 0, y: 0, width: tableview.frame.width, height: 44 * CGFloat(5))
    }
    
    private struct constants{
        static let Title : String = "HOW DID YOU HEAR ABOUT US"
        static let CellIdentifier : String = "Address Cell Identifier"
        
        static let cellReuseIdentifier = "cellIdentifier"
        static let cellHeight = 44.0
        
    }
    var printList: [String] = [
        "-Please Select-"
        , "Our Website"
        , "HAR"
        , "Drive By"
        , "Other Website"
        , "Word of Mouth"
        , "Realtor"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableHeight.constant = CGFloat(Double(printList.count) * constants.cellHeight)
        tableview.updateConstraintsIfNeeded()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return printList.count
    }
    
    
    
    func touched(tap : UITapGestureRecognizer){
       
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        
        let cell = tableView.dequeueReusableCellWithIdentifier(constants.cellReuseIdentifier, forIndexPath: indexPath)
        cell.textLabel?.text = printList[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.dismissViewControllerAnimated(true){
            if self.delegate != nil {
                self.delegate?.GoToPrint(self.printList[indexPath.row])
            }
        }
    }
    
    override var preferredContentSize: CGSize {
        get {
            return CGSize(width: tableview.frame.width, height: CGFloat(constants.cellHeight * Double(printList.count)))
        }
        set { super.preferredContentSize = newValue }
    }
    
    
    
    
    
}
