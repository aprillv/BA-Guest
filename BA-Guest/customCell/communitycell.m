//
//  communitycell.m
//  BA-Guest
//
//  Created by roberto ramirez on 2/4/14.
//  Copyright (c) 2014 lovetthomes. All rights reserved.
//

#import "communitycell.h"

@implementation communitycell

@synthesize idcia, cianame, city, webarea, webnm;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    int tx=2;
    int dw =self.frame.size.width;
    UILabel* lblname = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, 110, 44)];
    lblname.text=idcia;
    //    lblname.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview: lblname];
    tx=tx +110;
    
    UILabel * label = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, 1, 44)];
    label.backgroundColor=[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
    //    label.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin;
    [self.contentView addSubview: label];
    
    label = [[UILabel alloc] initWithFrame: CGRectMake( 0, 43, dw, 1)];
    label.backgroundColor=[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
    //    label.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin;
    [self.contentView addSubview: label];
    
    tx = tx+3;
    UILabel* lblpname = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, dw*.2-2, 44)];
    lblpname.text=cianame;
    //    lblpname.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview: lblpname];
    tx=tx +dw*.2-2;
    
    label = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, 1, 44)];
    label.backgroundColor=[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
    //    label.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin;
    [self.contentView addSubview: label];
    tx=tx+3;
    
    lblpname = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, dw*.12-2, 44)];
    lblpname.text=city;
    //    lblpname.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview: lblpname];
    tx=tx +dw*.12-2;
    
    label = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, 1, 44)];
    label.backgroundColor=[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
    //    label.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin;
    [self.contentView addSubview: label];
    tx=tx+3;
    
    lblpname = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, dw*.24-2, 44)];
    lblpname.text=webarea;
    //    lblpname.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview: lblpname];
    
    tx=tx +dw*.24-2;
    
    label = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, 1, 44)];
    label.backgroundColor=[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
    //    label.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin;
    [self.contentView addSubview: label];
    tx=tx+3;
    
    lblpname = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, dw-tx, 44)];
    lblpname.text=webnm;
    //    lblpname.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview: lblpname];

    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
