//
//  findrealtorfirstCell.h
//  BA-Guest
//
//  Created by roberto ramirez on 1/22/14.
//  Copyright (c) 2014 lovetthomes. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol findrealtorfirstCellDelegate

//@optional
-(void)doaClickeded:(NSString *)str :(BOOL)isup;
@end

@interface findrealtorfirstCell : UITableViewCell

@property (nonatomic, strong) id<findrealtorfirstCellDelegate> delegate;

@end