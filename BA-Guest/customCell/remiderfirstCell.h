//
//  remiderfirstCell.h
//  BA-Guest
//
//  Created by roberto ramirez on 1/24/14.
//  Copyright (c) 2014 lovetthomes. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol remiderfirstCellDelegate

//@optional
-(void)doaClicked:(NSString *)str :(BOOL)isup;
@end

@interface remiderfirstCell : UITableViewCell

@property (nonatomic, strong) id<remiderfirstCellDelegate> delegate;

@end