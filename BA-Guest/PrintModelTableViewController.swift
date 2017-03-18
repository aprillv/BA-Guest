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
    func GoToPrint(_ modelNm: String)
}
class PrintModelTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate{
    // MARK: - Constanse
    
    
    var delegate : ToDoPrintDelegate?
    
    
    
    @IBAction func dismissSelf(_ sender: UITapGestureRecognizer) {
        //        print(sender)
        //        let point = sender.locationInView(view)
        //        if !CGRectContainsPoint(tableview.frame, point) {
        self.dismiss(animated: true){}
        //        }
        
        
        
    }
    @IBOutlet var tableHeight: NSLayoutConstraint!
    
    @IBOutlet var tablex: NSLayoutConstraint!
    @IBOutlet var tabley: NSLayoutConstraint!
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let point = touch.location(in: view)
        return !tableview.frame.contains(point)
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
    
    fileprivate struct constants{
        static let Title : String = "HOW DID YOU HEAR ABOUT US"
        static let CellIdentifier : String = "Address Cell Identifier"
        
        static let cellReuseIdentifier = "cellIdentifier"
        static let cellHeight = 44.0
        
    }
    var printList: [String] = [
        "-Please Select-"
        , "Our Website"
        , "Social Media"
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return printList.count
    }
    
    
    
    func touched(_ tap : UITapGestureRecognizer){
       
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        let cell = tableView.dequeueReusableCell(withIdentifier: constants.cellReuseIdentifier, for: indexPath)
        cell.textLabel?.text = printList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true){
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
