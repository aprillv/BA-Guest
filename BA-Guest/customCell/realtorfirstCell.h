//
//  realtorfirstCell.h
//  BA-Guest
//
//  Created by roberto ramirez on 1/15/14.
//  Copyright (c) 2014 lovetthomes. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol realtorfirstCellDelegate

//@optional
-(void)doaClicked:(NSString *)str :(BOOL)isup;
@end

@interface realtorfirstCell : UITableViewCell

@property (nonatomic, strong) id<realtorfirstCellDelegate> delegate;

@end
