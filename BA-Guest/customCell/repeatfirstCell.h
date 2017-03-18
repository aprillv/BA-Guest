//
//  repeatfirstCell.h
//  BA-Guest
//
//  Created by roberto ramirez on 1/29/14.
//  Copyright (c) 2014 lovetthomes. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol repeatfirstCellDelegate

//@optional
-(void)doaClicked:(NSString *)str :(BOOL)isup;
@end
@interface repeatfirstCell : UITableViewCell
@property (nonatomic, strong) id<repeatfirstCellDelegate> delegate;
@end
