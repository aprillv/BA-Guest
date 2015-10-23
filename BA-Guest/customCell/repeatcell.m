//
//  repeatcell.m
//  BA-Guest
//
//  Created by roberto ramirez on 1/29/14.
//  Copyright (c) 2014 lovetthomes. All rights reserved.
//

#import "repeatcell.h"

@implementation repeatcell
@synthesize consultant,subject,webcommunity, visitdate;
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
    
    UILabel *lblagent = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, dw*.14, 44)];
    lblagent.text=visitdate;
    lblagent.textColor=[UIColor blackColor];
    [self.contentView addSubview: lblagent];
    tx=tx+dw*.14;
    
    UILabel * label = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, 1, 44)];
    label.backgroundColor=[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
    [self.contentView addSubview: label];
    tx=tx+3;
    
    UILabel *lblcompany = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, dw*.15, 44)];
    lblcompany.text=consultant;
    [self.contentView addSubview: lblcompany];
    tx=tx+dw*.15;
    
    label = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, 1, 44)];
    label.backgroundColor=[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
    [self.contentView addSubview: label];
    tx=tx+3;
    
    
    
   UILabel* lblstatus = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, dw*.25, 44)];
    lblstatus.text=webcommunity;
    [self.contentView addSubview: lblstatus];
    tx=tx+dw*.25;
    
    label = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, 1, 44)];
    label.backgroundColor=[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
    [self.contentView addSubview: label];
    tx=tx+3;
    
    
    
    lblstatus = [[UILabel alloc] initWithFrame: CGRectMake( tx, 0, dw-tx, 44)];
    lblstatus.text=subject;
    [self.contentView addSubview: lblstatus];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
