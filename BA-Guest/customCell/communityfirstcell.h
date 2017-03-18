//
//  communityfirstcell.h
//  BA-Guest
//
//  Created by roberto ramirez on 1/22/14.
//  Copyright (c) 2014 lovetthomes. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol communityfirstcellDelegate

//@optional
-(void)doaClicked:(NSString *)str :(BOOL)isup;
@end

@interface communityfirstcell : UITableViewCell
@property (nonatomic, strong) id<communityfirstcellDelegate> delegate;
@end
