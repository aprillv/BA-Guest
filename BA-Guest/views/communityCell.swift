//
//  communityCell.swift
//  BA-Guest
//
//  Created by April on 3/4/16.
//  Copyright © 2016 lovetthomes. All rights reserved.
//

import UIKit

@objcMembers class communityCell: UITableViewCell {

    @IBOutlet var ciaName: UILabel!
    @IBOutlet var cityName: UILabel!
    @IBOutlet var areaName: UILabel!
    @IBOutlet var communityName: UILabel!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        for a in self.contentView.subviews {
            if a.frame.width == 1 {
                for b in a.constraints{
                    b.constant = 1.0 / UIScreen.main.scale
                }
            }
        }
        
        let v = UIView()
        self.contentView.addSubview(v)
        v.backgroundColor = UIColor(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1)
        let leadingConstraint = NSLayoutConstraint(item:v,
            attribute: .leadingMargin,
            relatedBy: .equal,
            toItem: self.contentView,
            attribute: .leadingMargin,
            multiplier: 1.0,
            constant: 0);
        let trailingConstraint = NSLayoutConstraint(item:v,
            attribute: .trailingMargin,
            relatedBy: .equal,
            toItem: self.contentView,
            attribute: .trailingMargin,
            multiplier: 1.0,
            constant: 0);
        
        let bottomConstraint = NSLayoutConstraint(item: v,
            attribute: .bottomMargin,
            relatedBy: .equal,
            toItem: self.contentView,
            attribute: .bottomMargin,
            multiplier: 1.0,
            constant: 0);
        
        let heightContraint = NSLayoutConstraint(item: v,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: 1.0 / (UIScreen.main.scale));
        v.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, bottomConstraint, heightContraint])
    }
    public func setCellContent(_ item : wcfCommunityItem){
        ciaName.text = item.ciaName
        cityName.text = item.city
        areaName.text = item.webArea
        communityName.text = item.webCommunity
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            self.contentView.backgroundColor = CConstants.SearchBarBackColor
        }else{
            self.contentView.backgroundColor = UIColor.white
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.contentView.backgroundColor = CConstants.SearchBarBackColor
        }else{
            self.contentView.backgroundColor = UIColor.white
        }
    }
    
}
