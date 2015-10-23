//
//  guestlsfirstCell.h
//  BA-Guest
//
//  Created by roberto ramirez on 1/16/14.
//  Copyright (c) 2014 lovetthomes. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol guestlsfirstCellDelegate

//@optional
-(void)doaClicked:(NSString *)str :(BOOL)isup;
@end

@interface guestlsfirstCell : UITableViewCell
@property (nonatomic, strong) id<guestlsfirstCellDelegate> delegate;
@end
