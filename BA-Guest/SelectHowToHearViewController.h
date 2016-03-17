//
//  SelectHowToHearViewController.h
//  BA-Guest
//
//  Created by April on 3/10/16.
//  Copyright © 2016 lovetthomes. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SelectHowToHearDelegate

// define protocol functions that can be used in any class using this delegate
-(void)selectedItem:(NSString *)itemName;

@end

@interface SelectHowToHearViewController : UIViewController
@property (nonatomic, assign) id  delegate;
@end
