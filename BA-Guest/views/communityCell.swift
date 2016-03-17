//
//  communityCell.swift
//  BA-Guest
//
//  Created by April on 3/4/16.
//  Copyright © 2016 lovetthomes. All rights reserved.
//

import UIKit

class communityCell: UITableViewCell {

    @IBOutlet var ciaName: UILabel!
    @IBOutlet var cityName: UILabel!
    @IBOutlet var areaName: UILabel!
    @IBOutlet var communityName: UILabel!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        for a in self.contentView.subviews {
            if a.frame.width == 1 {
                for b in a.constraints{
                    b.constant = 1.0 / UIScreen.mainScreen().scale
                }
            }
        }
        
        let v = UIView()
        self.contentView.addSubview(v)
        v.backgroundColor = UIColor(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1)
        let leadingConstraint = NSLayoutConstraint(item:v,
            attribute: .LeadingMargin,
            relatedBy: .Equal,
            toItem: self.contentView,
            attribute: .LeadingMargin,
            multiplier: 1.0,
            constant: 0);
        let trailingConstraint = NSLayoutConstraint(item:v,
            attribute: .TrailingMargin,
            relatedBy: .Equal,
            toItem: self.contentView,
            attribute: .TrailingMargin,
            multiplier: 1.0,
            constant: 0);
        
        let bottomConstraint = NSLayoutConstraint(item: v,
            attribute: .BottomMargin,
            relatedBy: .Equal,
            toItem: self.contentView,
            attribute: .BottomMargin,
            multiplier: 1.0,
            constant: 0);
        
        let heightContraint = NSLayoutConstraint(item: v,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .NotAnAttribute,
            multiplier: 1.0,
            constant: 1.0 / (UIScreen.mainScreen().scale));
        v.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([leadingConstraint, trailingConstraint, bottomConstraint, heightContraint])
    }
    func setCellContent(item : wcfCommunityItem){
        ciaName.text = item.CiaName
        cityName.text = item.City
        areaName.text = item.WebArea
        communityName.text = item.WebCommunity
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        if highlighted {
            self.contentView.backgroundColor = CConstants.SearchBarBackColor
        }else{
            self.contentView.backgroundColor = UIColor.whiteColor()
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.contentView.backgroundColor = CConstants.SearchBarBackColor
        }else{
            self.contentView.backgroundColor = UIColor.whiteColor()
        }
    }
    
}
